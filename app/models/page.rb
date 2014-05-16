class Page < ActiveRecord::Base
  include Checkable

  belongs_to :chapter

  serialize :parser, JSON

  scope :unchecked, lambda { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }

  check def get_image
    parser.image_url
  end

end
