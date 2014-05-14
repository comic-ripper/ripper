class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|

      t.timestamp :scheduled_at
      t.timestamps
    end
  end
end
