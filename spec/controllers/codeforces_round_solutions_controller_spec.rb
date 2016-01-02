require 'rails_helper'
require 'support/solution_controller'
RSpec.describe CodeforcesRoundSolutionsController, type: :controller do

  it_behaves_like 'SolutionController',
                  :codeforces_round_solution,
                  :codeforces_round_solutions_path

end
