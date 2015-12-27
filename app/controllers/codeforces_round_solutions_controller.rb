class CodeforcesRoundSolutionsController < SolutionsController

  private
    def solution_class
      CodeforcesRoundSolution
    end

    def solution_params
      params.required(:codeforces_round_solution)
          .permit(:round_number, :division_number, :level, :original_link)
    end

    def search_params
      params.permit(:round_number, :division_number, :level, :author, :language)
    end

    def attachment_param
      params[:codeforces_round_solution][:attachment]
    end

    def solution_info
      {
          Round: @solution.round_number,
          Division: @solution.division_number,
          Level: @solution.level,
          Language: @solution.language.name,
          'Original problem': @solution.original_link
      }
    end

    def assign_to_index_variable(solutions)
      @codeforces_round_solutions = solutions
    end

end
