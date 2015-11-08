class CreateTopCoderSrmSolutions < ActiveRecord::Migration
  def change
    create_table :top_coder_srm_solutions do |entry|
      entry.belongs_to :user, index: true, foreign_key: true
      entry.belongs_to :contest, index: true, foreign_key: true

      entry.integer :srm_number, null: false
      entry.integer :division_number, null: false

      entry.string :save_path, null: true

      entry.timestamps null: false
    end
  end
end
