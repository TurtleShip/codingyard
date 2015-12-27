class AddCachedVotesToSolutions < ActiveRecord::Migration
  def change
    add_column :codeforces_round_solutions, :cached_votes_total, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_votes_score, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_votes_up, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_votes_down, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_weighted_score, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_weighted_total, :integer, :default => 0
    add_column :codeforces_round_solutions, :cached_weighted_average, :float, :default => 0.0
    add_index :codeforces_round_solutions, :cached_votes_total
    add_index :codeforces_round_solutions, :cached_votes_score
    add_index :codeforces_round_solutions, :cached_votes_up
    add_index :codeforces_round_solutions, :cached_votes_down
    add_index :codeforces_round_solutions, :cached_weighted_score
    add_index :codeforces_round_solutions, :cached_weighted_total
    add_index :codeforces_round_solutions, :cached_weighted_average

    add_column :uva_solutions, :cached_votes_total, :integer, :default => 0
    add_column :uva_solutions, :cached_votes_score, :integer, :default => 0
    add_column :uva_solutions, :cached_votes_up, :integer, :default => 0
    add_column :uva_solutions, :cached_votes_down, :integer, :default => 0
    add_column :uva_solutions, :cached_weighted_score, :integer, :default => 0
    add_column :uva_solutions, :cached_weighted_total, :integer, :default => 0
    add_column :uva_solutions, :cached_weighted_average, :float, :default => 0.0
    add_index :uva_solutions, :cached_votes_total
    add_index :uva_solutions, :cached_votes_score
    add_index :uva_solutions, :cached_votes_up
    add_index :uva_solutions, :cached_votes_down
    add_index :uva_solutions, :cached_weighted_score
    add_index :uva_solutions, :cached_weighted_total
    add_index :uva_solutions, :cached_weighted_average

    add_column :top_coder_srm_solutions, :cached_votes_total, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_votes_score, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_votes_up, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_votes_down, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_weighted_score, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_weighted_total, :integer, :default => 0
    add_column :top_coder_srm_solutions, :cached_weighted_average, :float, :default => 0.0
    add_index :top_coder_srm_solutions, :cached_votes_total
    add_index :top_coder_srm_solutions, :cached_votes_score
    add_index :top_coder_srm_solutions, :cached_votes_up
    add_index :top_coder_srm_solutions, :cached_votes_down
    add_index :top_coder_srm_solutions, :cached_weighted_score
    add_index :top_coder_srm_solutions, :cached_weighted_total
    add_index :top_coder_srm_solutions, :cached_weighted_average

  end
end
