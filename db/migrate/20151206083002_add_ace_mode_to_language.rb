class AddAceModeToLanguage < ActiveRecord::Migration
  def change
    add_column :languages, :ace_mode, :string
    change_column_null :languages, :ace_mode, false, :plain_text
  end
end
