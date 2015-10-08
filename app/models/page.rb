class Page < ActiveRecord::Base
  include Checkable

  belongs_to :chapter

  serialize :parser

  mount_uploader :image, PageImageUploader

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
