class Comic < ActiveRecord::Base
  include Checkable

  has_many :chapters

  serialize :parser_data

  validates :title, presence: true

  check def index
    puts "I've been checked"
  end

  check def ive_been_shot
    puts "#{id} has been shot"
  end
end
