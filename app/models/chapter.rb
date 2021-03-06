# frozen_string_literal: true
require 'unsafe_json'
require 'zip'

class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  mount_uploader :archive, ChapterArchiveUploader
  scope :unbuilt, -> { where('archive IS NULL  ') }
  scope :built, -> { where('archive IS NOT NULL') }

  serialize :parser, UnsafeJSON

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

    number_part.rjust(4, '0') + partial_part.to_s
  end

  def filename
    "#{comic.title}_ch#{number_for_file}_[#{id}]"
  end

  def complete?
    checked? && pages.all?(&:checked?)
  end

  def display_name
    display = ''
    display += "Vol.#{volume} " if volume
    display += "Ch.#{number}"
    display + ": #{title}"
  end

  def update_size
    update apparent_size: pages.map(&:file_size).compact.sum
  end

  on_check def update_pages
    parser.pages.map do |page|
      next if pages.where(number: page.number).any?
      Page.create(
        chapter: self,
        number: page.number,
        parser: page
      )
    end
  end

  def delay_build
    BuilderWorker.perform_async(id)
  end

  ARCHIVE_EXT = 'zip'.freeze

  def build
    build_zip
  end

  def build_zip
    fail 'Chapter not complete' unless complete?
    temp = Tempfile.new filename + '.' + 'zip'
    begin
      Zip::File.open(temp.path, Zip::File::CREATE) do |zipfile|
        pages.each do |page|
          page.image.cache!
          zipfile.add page.image.file.filename, page.image.file.path
        end
      end

      archive.store! temp
      save
    ensure
      temp.close
      temp.unlink
    end
  end
end
