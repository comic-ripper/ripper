class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  mount_uploader :archive, ChapterArchiveUploader
  scope :unbuilt, lambda { where("archive IS NULL  ") }
  scope :built, lambda { where("archive IS NOT NULL") }

  serialize :parser, JSON

  def number_for_file
    number.rjust(6, "0")
  end

  def filename
    "[#{id}]#{comic.title}_#{number_for_file}"
  end

  def complete?
    checked? && pages.all?(&:checked?)
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

        self.archive.store! temp
        self.save
      ensure
        temp.close
        temp.unlink
      end
    else
      fail "Chapter not complete"
    end
  end
end
