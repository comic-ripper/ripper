class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  serialize :parser_data

end
