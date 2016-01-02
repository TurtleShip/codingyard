require 'rails_helper'
require 'support/solutions_controller'

RSpec.describe TopCoderSrmSolutionsController, type: :controller do

  it_behaves_like 'SolutionsController',
                  :top_coder_srm_solution,
                  :top_coder_srm_solutions_path

end
