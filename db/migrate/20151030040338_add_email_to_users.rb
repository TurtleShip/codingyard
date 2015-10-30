class AddEmailToUsers < ActiveRecord::Migration
  def change
    # Fxxk sqlite3 : https://viget.com/extend/adding-a-not-null-column-to-an-existing-table
    add_column :users, :email, :string
    change_column_null :users, :email, false
  end
end
