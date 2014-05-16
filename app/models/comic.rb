class Comic < ActiveRecord::Base
  include Checkable

  has_many :chapters

  serialize :parser, JSON

  validates :title, presence: true

  scope :unchecked, lambda { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }

  check def update_chapters
    parser.chapters.map do |chapter|
      unless chapters.where(number: chapter.number).any?
        Chapter.create(
          comic: self,
          number: chapter.number,
          volume: chapter.volume,
          title:  chapter.title,
          parser: chapter
        )
      end
    end
  end
end
