class AddOriginalLinkToTopCoderSrmSolutions < ActiveRecord::Migration
  def change
    add_column :top_coder_srm_solutions, :original_link, :string
  end
end
