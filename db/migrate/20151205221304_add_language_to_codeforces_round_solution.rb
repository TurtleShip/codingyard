class AddLanguageToCodeforcesRoundSolution < ActiveRecord::Migration
  def change
    add_reference :codeforces_round_solutions, :language, index: true, foreign_key: true
  end
end
