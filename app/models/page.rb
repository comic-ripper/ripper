class Page < ActiveRecord::Base
  include Checkable

  belongs_to :chapter

  serialize :parser, JSON

  check def get_image
    parser.image_url
  end

end
