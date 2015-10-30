class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |entry|
      entry.string :username, null: false
      entry.timestamps null: false
    end
  end
end
