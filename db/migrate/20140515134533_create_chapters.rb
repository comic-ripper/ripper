class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :comic, index: true

      t.string :number, index: true

      t.integer :volume

      t.string :title

      t.text :parser_data

      t.timestamp :read_at

      t.integer :apparent_size

      t.timestamps
    end
  end
end
