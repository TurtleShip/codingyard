class CodeforcesRoundSolutionsController < ApplicationController

  before_action :can_upload, only: [:new, :create]
  before_action :find_solution, only: [:show, :edit, :update, :destroy]
  before_action :languages, only: [:new, :create, :show, :edit, :update]

  def index
    @solutions = CodeforcesRoundSolution.all
  end

  def show
    @solution_info = {
        Round: @solution.round_number,
        Division: @solution.division_number,
        Level: @solution.level,
        Language: @solution.language.name
    }
  end

  def new
    @solution = CodeforcesRoundSolution.new
  end

  def edit
  end

  def create
    @solution = CodeforcesRoundSolution.new_with_relations(solution_params, current_user, Language.find(params[:language]))
    if @solution.save
      flash[:success] = 'Solutions has been successfully saved.'
      redirect_to @solution
    else
      render :new
    end


  end

  def update
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Codeforces round solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to codeforces_round_solutions_url, notice: 'Codeforces round solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def find_solution
      @solution = CodeforcesRoundSolution.find(params[:id])
    end

    def solution_params
      params.require(:codeforces_round_solution)
          .permit(:round_number, :division_number, :level)
    end

    def languages
      @languages ||= Language.all
    end

end
