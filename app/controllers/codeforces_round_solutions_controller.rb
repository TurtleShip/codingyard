class CodeforcesRoundSolutionsController < SolutionsController

  def download
    send_data solution_content(@solution.save_path), disposition: 'attachment', filename: @solution.save_path.split('/').last
  end


  def edit
    fill_content
  end

  def update
    if @solution.update_attributes(solution_params)
      flash.now[:success] = "Solution ##{@solution.id} has been successfully updated."
    end
    render :edit
  end

  def destroy
    solution_id = @solution.id
    @solution.destroy
    flash[:success] = "Solution ##{solution_id} was successfully deleted."
    redirect_to codeforces_round_solutions_url
  end

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

end
