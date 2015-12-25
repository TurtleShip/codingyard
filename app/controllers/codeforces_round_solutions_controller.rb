class CodeforcesRoundSolutionsController < SolutionsController

  before_action :find_solution, only: [:show, :edit, :update, :destroy, :download]
  before_action :languages, only: [:new, :create, :show, :edit, :update, :index]
  before_action :has_required_params, only: [:create]
  # before_action :find_language, only: [:create]
  before_action :check_upload_perm, only: [:new, :create]
  before_action :check_delete_perm, only: [:destroy]
  before_action :check_edit_perm, only: [:edit, :update]

  def index
    filtered_params = params.permit(:round_number, :division_number, :level, :author, :language)
    filtered_params.reject! { |key,value| value.blank? }

    @warnings = []
    author_username = filtered_params[:author]
    if author_username.present? && !filter_author(filtered_params, author_username)
      @warnings << "No user found by name '#{author_username}', so the author field is ignored."
    end

    language_name = filtered_params[:language]
    if language_name.present? && !filter_language(filtered_params, language_name)
      @warnings << "#{language_name} is not registered yet, so the language field is ignored."
    end

    @codeforces_round_solutions = CodeforcesRoundSolution
    .where(filtered_params)
    .paginate(page: params[:page], :per_page => PER_PAGE)
  end

  def show
    @solution_info = {
        Round: @solution.round_number,
        Division: @solution.division_number,
        Level: @solution.level,
        Language: @solution.language.name,
        'Original problem': @solution.original_link
    }
    fill_content
  end

  def download
    send_data solution_content(@solution.save_path), disposition: 'attachment', filename: @solution.save_path.split('/').last
  end

  def new
    @solution = CodeforcesRoundSolution.new
    @is_new = true
    @supported_file_types = Language.get_all_extensions_concat
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

    def find_solution
      @solution ||= CodeforcesRoundSolution.find_by_id(params[:id])
      if @solution.nil?
        flash[:danger] = "There is no solution #{params[:id]}"
        redirect_back_or(codeforces_round_solutions_path)
      else
        @solution
      end
    end

    def new_solution
      @solution = CodeforcesRoundSolution.new
    end

    def new_solution_with_relations
      @solution = CodeforcesRoundSolution.new_with_relations(solution_params, current_user, @language)
    end

    def solution_params
      params.required(:codeforces_round_solution)
          .permit(:round_number, :division_number, :level, :original_link)
    end

    def attachment_param
      params[:codeforces_round_solution][:attachment]
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

end
