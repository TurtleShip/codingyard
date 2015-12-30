class AddCodeforcesHandleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :codeforces_handle, :string
  end
end
