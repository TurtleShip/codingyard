require 'rails_helper'
require 'support/shared_examples/solutions_controller'

RSpec.describe CodeforcesRoundSolutionsController, type: :controller do

  it_behaves_like 'SolutionsController',
                  :codeforces_round_solution,
                  :codeforces_round_solutions_path

end
