class CreateCodeforcesRoundSolutions < ActiveRecord::Migration
  def change
    create_table :codeforces_round_solutions do |entry|
      entry.belongs_to :user, index: true, foreign_key: true
      entry.belongs_to :contest, index: true, foreign_key: true

      entry.integer :round_number, null: false
      entry.integer :division_number, null: false
      entry.string :level, null: false

      entry.string :save_path

      entry.timestamps null: false
    end
  end
end
