class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |entry|
      entry.string :name, null: false
      entry.string :url, null: true
      entry.string :description, null: true
      entry.timestamps null: false
    end
  end
end
