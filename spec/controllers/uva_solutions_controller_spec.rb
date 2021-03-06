require 'rails_helper'
require 'support/shared_examples/solutions_controller'

RSpec.describe UvaSolutionsController, type: :controller do

  it_behaves_like 'SolutionsController',
                  :uva_solution,
                  :uva_solutions_path
end
