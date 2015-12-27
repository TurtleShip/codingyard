class UvaSolutionsController < SolutionsController


  def solution_class
    UvaSolution
  end

  def solution_params
    params.required(:uva_solution)
        .permit(:problem_number, :original_link)
  end

  def search_params
    params.permit(:problem_number, :author, :language)
  end

  def attachment_param
    params[:uva_solution][:attachment]
  end

  def solution_info
    {
        'Problem number': @solution.problem_number,
        Language: @solution.language.name,
        'Original problem': @solution.original_link
    }
  end

  def assign_to_index_variable(solutions)
    @uva_solutions = solutions
  end

end
