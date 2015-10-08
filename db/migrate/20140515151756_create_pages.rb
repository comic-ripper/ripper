class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :chapter, index: true

      t.integer :number, null: false

      t.text :parser

      t.string :image

      t.integer :file_size

      t.timestamp :checked_at
      t.timestamps
    end
  end
end
