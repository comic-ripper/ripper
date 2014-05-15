class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title, null: false, default: ""

      t.belongs_to :parser_configuration, index: true

      t.text :parser_data

      t.timestamps
    end
  end
end
