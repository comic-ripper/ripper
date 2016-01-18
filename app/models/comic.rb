require 'unsafe_json'

class Comic < ActiveRecord::Base
  include Checkable

  has_many :chapters
  serialize :parser, UnsafeJSON

  validates :title, presence: true

  on_check def update_chapters
    parser.chapters.map do |chapter|
      next if chapters.select { |c| c.parser.to_json == chapter.to_json }.any?
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
