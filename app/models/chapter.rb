class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  has_paper_trail

  mount_uploader :archive, ChapterArchiveUploader
  scope :unbuilt, -> { where("archive IS NULL  ") }
  scope :built, -> { where("archive IS NOT NULL") }

  serialize :parser, JSON

  def next
    chapters = comic.chapters.order(number: :asc).to_a
    chapter_index = chapters.index(self)

    chapters[chapter_index + 1]
  end

  def prev
    chapters = comic.chapters.order(number: :asc).to_a
    chapter_index = chapters.index(self)

    chapters[chapter_index - 1] if chapter_index > 0
  end

  def number_for_file
    number_part, partial_part = number.match(/(\d+)(.*)/)[1..2]

    number_part.rjust(4, "0") + partial_part.to_s
  end

  def filename
    "[#{id}]#{comic.title}_#{number_for_file}"
  end

  def complete?
    checked? && pages.all?(&:checked?)
  end

  def display_name
    display = ""
    display += "Vol.#{volume} " if volume
    display += "Ch.#{number}"
    display + ": #{title}"
  end

  def update_size
    update apparent_size: pages.map(&:file_size).compact.sum
  end

  on_check def update_pages
    parser.pages.map do |page|
      unless pages.where(number: page.number).any?
        Page.create(
          chapter: self,
          number: page.number,
          parser: page
        )
      end
    end
  end

  def delay_build
    BuilderWorker.perform_async(id)
  end

  ARCHIVE_EXT = "7z"
  def build
    if complete?
      temp = Tempfile.new filename + "." + ARCHIVE_EXT
      begin
        SevenZipRuby::Writer.open(temp) do |szr|
          szr.method = "LZMA2"
          pages.each do |page|
            szr.add_file page.image.file.path, as: page.image.file.filename
          end
        end

        archive.store! temp
        save
      ensure
        temp.close
        temp.unlink
      end
    else
      fail "Chapter not complete"
    end
  end
end
