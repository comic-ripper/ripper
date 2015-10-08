class Comic < ActiveRecord::Base
  include Checkable

  has_many :chapters

  serialize :parser, JSON

  validates :title, presence: true

  has_paper_trail ignore: [:updated_at, :checked_at]

  on_check def update_chapters
    parser.chapters.map do |chapter|
      unless chapters.select { |c| c.parser.to_json == chapter.to_json }.any?
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
