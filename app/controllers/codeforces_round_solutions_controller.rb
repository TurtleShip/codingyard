class CodeforcesRoundSolutionsController < ApplicationController

  before_action :can_upload, only: [:new, :create]
  before_action :find_solution, only: [:show, :edit, :update, :destroy]
  
  def index
    @solutions = CodeforcesRoundSolution.all
  end

  def show
  end

  def new
    @solution = CodeforcesRoundSolution.new
  end
  
  def edit
  end
  
  def create
    @solution = CodeforcesRoundSolution.new(solution_params)

    respond_to do |format|
      if @solution.save
        format.html { redirect_to @solution, notice: 'Codeforces round solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
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
      params[:codeforces_round_solution]
    end



end
