class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  serialize :parser, JSON

  check def update_pages
    parser.pages.map do |page|
      unless pages.where(number: page.number).any?
        Page.create(
          chapter: self,
          number: page.number,
          parser: page
        )
      end
    end
  end
end
