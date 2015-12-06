class CodeforcesRoundSolutionsController < ApplicationController

  before_action :can_upload, only: [:new, :create]
  before_action :find_solution, only: [:show, :edit, :update, :destroy]
  before_action :languages, only: [:new, :create, :show, :edit, :update]

  def index
    @codeforces_round_solutions = CodeforcesRoundSolution.paginate(page: params[:page], :per_page => CodeforcesRoundSolution::PER_PAGE)
    @total = CodeforcesRoundSolution.all.count
  end

  def show
    @solution_info = {
        Round: @solution.round_number,
        Division: @solution.division_number,
        Level: @solution.level,
        Language: @solution.language.name
    }
    content = solution_content(@solution.save_path)
    if content
      @content = content
    else
      flash[:danger] = 'Sorry, we are having trouble loading your solution. Please try again later.'
    end
  end

  def new
    @solution = CodeforcesRoundSolution.new

  end

  def edit
  end

  def create
    @solution = CodeforcesRoundSolution.new_with_relations(solution_params, current_user, Language.find(params[:language]))

    # Check for attachment
    attachment = params[:codeforces_round_solution][:attachment]

    unless attachment
      flash[:warning] = 'Please attach a solution.'
      render :new
      return
    end

    if attachment.size > 1.megabytes
      flash[:danger] = 'File cannot be bigger than 1 MB (megabytes).'
      render :new
      return
    end

    file = attachment.read
    path = @solution.create_save_path(file)
    upload_success = upload_solution path, file
    @solution.save_path = path


    if upload_success && @solution.save
      flash[:success] = 'Solutions has been successfully uploaded!'
      redirect_to @solution
    else
      flash[:warning] = 'Sorry, we are having trouble uploading your solution. Please try again later.' unless upload_success
      render :new
    end


  end

  def update
    if @solution.update(solution_params)
      flash[:success] = "Solution ##{@solution.id} has been successfully updated."
      redirect_to @solution
    else
      render :edit
    end
  end

  def destroy
    solution_id = @solution.id
    @solution.destroy
    flash[:success] = "Solution ##{solution_id} was successfully deleted."
    redirect_to codeforces_round_solutions_url
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
