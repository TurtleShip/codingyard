class AddOriginalLinkToCodeforcesRoundSolutions < ActiveRecord::Migration
  def change
    add_column :codeforces_round_solutions, :original_link, :string
  end
end
