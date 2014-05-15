class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :comic, index: true

      t.string :number, index: true

      t.integer :volume, null: true

      t.text :parser_data

      t.timestamp :read_at, null: true

      t.integer :apparent_size, null: true

      t.timestamps
    end
  end
end
