class Page < ActiveRecord::Base
  include Checkable

  belongs_to :chapter

  serialize :parser_data

end
