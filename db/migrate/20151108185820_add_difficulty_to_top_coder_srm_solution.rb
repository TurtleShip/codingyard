class AddDifficultyToTopCoderSrmSolution < ActiveRecord::Migration
  def change
    add_column :top_coder_srm_solutions, :difficulty, :string
    change_column_null :top_coder_srm_solutions, :difficulty, false
  end
end
