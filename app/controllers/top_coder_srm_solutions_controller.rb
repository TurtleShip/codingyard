class TopCoderSrmSolutionsController < SolutionsController

  private
    def solution_class
      TopCoderSrmSolution
    end

    def solution_params
      params.required(:top_coder_srm_solution)
          .permit(:srm_number, :division_number, :difficulty, :original_link)
    end

    def search_params
      params.permit(:srm_number, :division_number, :difficulty, :author, :language)
    end

    def attachment_param
      params[:top_coder_srm_solution][:attachment]
    end

    def solution_info
      {
          SRM: @solution.srm_number,
          Division: @solution.division_number,
          difficulty: @solution.difficulty,
          Language: @solution.language.name,
          'Original problem': @solution.original_link
      }
    end

    def assign_to_index_variable(solutions)
      @top_coder_srm_solutions = solutions
    end
end
