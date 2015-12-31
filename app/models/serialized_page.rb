class SerializedPage
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Serializers::JSON
  extend CarrierWave::Mount

  include Checkable

  attr_accessor :number, :parser, :image, :file_size, :checked_at

  def attributes
    {
      'number': nil,
      'parser': nil,
      'image': nil,
      'file_size': nil,
      'checked_at': nil
    }
  end

  # belongs_to :chapter

  # serialize :parser, UnsafeJSON

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
