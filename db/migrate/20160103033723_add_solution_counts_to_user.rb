class AddSolutionCountsToUser < ActiveRecord::Migration

  def change

    add_column :users, :codeforces_round_solutions_count, :integer, default: 0
    add_column :users, :top_coder_srm_solutions_count, :integer, default: 0
    add_column :users, :uva_solutions_count, :integer, default: 0

  end

end
