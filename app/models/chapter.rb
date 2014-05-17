class Chapter < ActiveRecord::Base
  include Checkable

  belongs_to :comic
  has_many :pages

  serialize :parser, JSON

  def number_for_file
    number.rjust(6, "0")
  end

  def filename
    "[#{id}]#{comic.title}_#{number_for_file}"
  end

  def complete?
    pages.all?(&:checked?)

  end

  on_check def update_pages
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
