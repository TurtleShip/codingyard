class AddLanguageToTopCoderSrmSolution < ActiveRecord::Migration
  def change
    add_reference :top_coder_srm_solutions, :language, index: true, foreign_key: true
  end
end
