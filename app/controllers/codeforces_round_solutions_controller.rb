class CodeforcesRoundSolutionsController < ApplicationController
  before_action :set_codeforces_round_solution, only: [:show, :edit, :update, :destroy]

  # GET /codeforces_round_solutions
  # GET /codeforces_round_solutions.json
  def index
    @codeforces_round_solutions = CodeforcesRoundSolution.all
  end

  # GET /codeforces_round_solutions/1
  # GET /codeforces_round_solutions/1.json
  def show
  end

  # GET /codeforces_round_solutions/new
  def new
    @codeforces_round_solution = CodeforcesRoundSolution.new
  end

  # GET /codeforces_round_solutions/1/edit
  def edit
  end

  # POST /codeforces_round_solutions
  # POST /codeforces_round_solutions.json
  def create
    @codeforces_round_solution = CodeforcesRoundSolution.new(codeforces_round_solution_params)

    respond_to do |format|
      if @codeforces_round_solution.save
        format.html { redirect_to @codeforces_round_solution, notice: 'Codeforces round solution was successfully created.' }
        format.json { render :show, status: :created, location: @codeforces_round_solution }
      else
        format.html { render :new }
        format.json { render json: @codeforces_round_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codeforces_round_solutions/1
  # PATCH/PUT /codeforces_round_solutions/1.json
  def update
    respond_to do |format|
      if @codeforces_round_solution.update(codeforces_round_solution_params)
        format.html { redirect_to @codeforces_round_solution, notice: 'Codeforces round solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @codeforces_round_solution }
      else
        format.html { render :edit }
        format.json { render json: @codeforces_round_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codeforces_round_solutions/1
  # DELETE /codeforces_round_solutions/1.json
  def destroy
    @codeforces_round_solution.destroy
    respond_to do |format|
      format.html { redirect_to codeforces_round_solutions_url, notice: 'Codeforces round solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codeforces_round_solution
      @codeforces_round_solution = CodeforcesRoundSolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def codeforces_round_solution_params
      params[:codeforces_round_solution]
    end
end
