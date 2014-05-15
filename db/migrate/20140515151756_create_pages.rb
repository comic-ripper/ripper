class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :chapter, index: true

      t.integer :number, null: false

      t.text :parser_data

      t.string :file_path
      t.integer :size

      t.timestamps
    end
  end
end
