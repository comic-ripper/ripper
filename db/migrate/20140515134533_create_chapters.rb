class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :comic, index: true

      t.timestamps
    end
  end
end
