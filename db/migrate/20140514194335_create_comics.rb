class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title, null: false, default: ""

      t.text :parser_data

      t.timestamps
    end
  end
end
