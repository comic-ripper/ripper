require 'unsafe_json'

class Page < ActiveRecord::Base
  include Checkable

  scope :chapter_order, lambda {
    joins(:chapter).order("chapters.number ASC, pages.number ASC")
  }

  belongs_to :chapter

  serialize :parser, UnsafeJSON

  mount_uploader :image, PageImageUploader

  def serialized_page
    SerializedPage.new(
      number: number, parser: parser,
      image: image, file_size: file_size,
      checked_at: checked_at
    )
  end

  def file_number
    number.to_s.rjust 6, "0"
  end

  on_check def download_image
    unless image.file && image.file.exists?
      self.remote_image_url = parser.image_url
      save
    end
    update file_size: image.size
    chapter.update_size
  end

  on_uncheck :remove_image!
end
