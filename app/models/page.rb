class Page < ActiveRecord::Base
  include Checkable

  belongs_to :chapter

  serialize :parser, JSON

  mount_uploader :image, PageImageUploader

  has_paper_trail


  def file_number
    number.to_s.rjust 6, "0"
  end

  on_check def get_image
    unless self.image.file && self.image.file.exists?
      self.remote_image_url = parser.image_url
      save
    end
    update file_size: image.size
    chapter.update_size
  end

  on_uncheck :remove_image!

end
