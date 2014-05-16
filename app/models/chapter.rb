class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  serialize :parser, JSON

  scope :unchecked, lambda { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }

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
