class CreateUvaSolutions < ActiveRecord::Migration
  def change
    create_table :uva_solutions do |entry|

      entry.belongs_to :user, index: true, foreign_key: true
      entry.belongs_to :contest, index: true, foreign_key: true
      entry.belongs_to :language, index: true, foreign_key: true

      entry.integer :problem_number, null: false

      entry.string :save_path, null: true
      entry.string :original_link, null: true

      entry.timestamps null: false
    end
  end
end
