class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :comic, index: true

      t.string :number, index: true

      t.integer :volume

      t.string :title

      t.text :parser

      t.timestamp :read_at

      t.integer :apparent_size

      t.string :archive

      t.timestamp :checked_at
      t.timestamps
    end
  end
end
