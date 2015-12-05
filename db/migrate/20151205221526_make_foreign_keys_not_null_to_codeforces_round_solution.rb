class MakeForeignKeysNotNullToCodeforcesRoundSolution < ActiveRecord::Migration
  def change
    change_column_null :codeforces_round_solutions, :contest_id, false
    change_column_null :codeforces_round_solutions, :user_id, false
    change_column_null :codeforces_round_solutions, :language_id, false
  end
end
