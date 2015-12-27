class AddTitleToUvaSolutions < ActiveRecord::Migration
  def change
    add_column :uva_solutions, :title, :string, null: true
  end
end
