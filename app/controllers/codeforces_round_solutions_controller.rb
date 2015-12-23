class CodeforcesRoundSolutionsController < ApplicationController

  UPLOAD_SIZE_LIMIT = 1.megabytes

  before_action :find_solution, only: [:show, :edit, :update, :destroy]
  before_action :languages, only: [:new, :create, :show, :edit, :update]
  before_action :has_required_params, only: [:create]
  before_action :find_language, only: [:create]
  before_action :can_upload, only: [:new, :create]
  before_action :can_delete, only: [:destroy]
  before_action :can_edit, only: [:edit, :update]

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
    fill_content
  end

  def new
    @solution = CodeforcesRoundSolution.new
    @is_new = true
    @supported_file_types = Language.get_all_extensions_concat
  end

  def edit
    fill_content
  end

  def create
    @solution = CodeforcesRoundSolution.new_with_relations(solution_params, current_user, Language.find_by_name(params[:language]))

    # Check for attachment
    attachment = params[:codeforces_round_solution][:attachment]

    if attachment.blank?
      flash.now[:danger] = 'Please attach a solution.'
      render :new
      return
    end

    if attachment.size > UPLOAD_SIZE_LIMIT
      flash.now[:danger] = 'File cannot be bigger than 1 MB (megabytes).'
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
      flash.now[:danger] = 'Sorry, we are having trouble uploading your solution. Please try again later.' unless upload_success
      render :new
    end


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

    def find_solution
      @solution = CodeforcesRoundSolution.find(params[:id])
      if @solution.nil?
        flash[:danger] = "There is no solution #{params[:id]}"
        redirect_back_or(codeforces_round_solutions_path)
      end
    end

    def find_language
      @language = Language.find_by_name(params[:language])
      if @language.nil?
        flash[:danger] = "There is no language #{params[:language]}"
        redirect_back_or(new_codeforces_round_solution_path)
      end
    end

    def solution_params
      params.required(:codeforces_round_solution)
          .permit(:round_number, :division_number, :level)
    end

    def languages
      @languages ||= Language.all
    end

    def has_required_params
      @solution = CodeforcesRoundSolution.new
      if params.blank?
        @solution.errors.add(:parameters, 'must be provided')
      else
        tmp_params = params[:codeforces_round_solution]
        if tmp_params.blank?
          @solution.errors.add(:parameters, 'missing values for codeforces_round_solution')
        else
          @solution.errors.add(:attachment, 'must be provided') unless tmp_params[:attachment].present?
        end
          @solution.errors.add(:language, 'must be specified') unless params[:language].present?
      end

      render :new unless @solution.errors.empty?
    end

    def fill_content
      @content = solution_content(@solution.save_path)

      if @content

      end
      flash[:danger] = 'Sorry, we are having trouble loading your solution. Please try again later.' unless @content

      # Content could be a zip file in which case we can't properly show content as text file.
      @content = 'Content is not properly encoded (likely a binary/zip file) and therefore cannot be displayed.' if @content && !@content.valid_encoding?
    end
end
