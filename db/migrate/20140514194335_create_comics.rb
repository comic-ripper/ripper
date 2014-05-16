class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title, null: false

      t.text :parser
      
      t.timestamp :checked_at
      t.timestamps
    end
  end
end
