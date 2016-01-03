class AddSolutionsCountToUser < ActiveRecord::Migration

  def change
    add_column :users, :solutions_count, :integer, default: 0
  end

end
