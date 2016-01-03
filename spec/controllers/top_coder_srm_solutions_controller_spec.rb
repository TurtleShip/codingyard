require 'rails_helper'
require 'support/shared_examples/solutions_controller'

RSpec.describe TopCoderSrmSolutionsController, type: :controller do

  it_behaves_like 'SolutionsController',
                  :top_coder_srm_solution,
                  :top_coder_srm_solutions_path

end
