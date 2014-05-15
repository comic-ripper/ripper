class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
end
