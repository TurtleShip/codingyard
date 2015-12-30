class AddUvaHandleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uva_handle, :string
  end
end
