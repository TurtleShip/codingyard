class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |entry|
      entry.string :name, null: false
      entry.string :extension, null: false
      entry.timestamps null: false
    end
  end
end
