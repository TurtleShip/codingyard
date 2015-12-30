class AddTopcoderHandleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :topcoder_handle, :string
  end
end
