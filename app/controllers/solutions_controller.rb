class SolutionsController < ApplicationController
  # This class contains controller actions common to Controllers that handle solutions.
  # Take a look at CodeforcesRoundSolutionsController for a use case of this controller.

  PER_PAGE = 30 # Number of solutions to display per page during pagination
  UPLOAD_SIZE_LIMIT = 1.megabytes

  before_filter :find_language, only: [:create]

  def index
    filtered_params = search_params.reject { |key,value| value.blank? }

    @warnings = []
    author_username = filtered_params[:author]
    if author_username.present? && !filter_author(filtered_params, author_username)
      @warnings << "No user found by name '#{author_username}', so the author field is ignored."
    end

    language_name = filtered_params[:language]
    if language_name.present? && !filter_language(filtered_params, language_name)
      @warnings << "#{language_name} is not registered yet, so the language field is ignored."
    end

    @codeforces_round_solutions = filter_solution(filtered_params)
                                      .paginate(page: params[:page], :per_page => PER_PAGE)
  end

  def new
    @solution = new_solution
    @is_new = true
    @supported_file_types = Language.get_all_extensions_concat
  end

  def create
    @solution = new_solution_with_relations

    # Check for attachment
    attachment = attachment_param

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

  protected

  def filter_solution(search_params)
    raise NotImplementedError
  end

  def find_solution
    raise NotImplementedError
  end

  def new_solution
    raise NotImplementedError
  end

  def new_solution_with_relations
    raise NotImplementedError
  end

  # filter parameters required/permitted for the solution this controller is handling.
  def solution_params
    raise NotImplementedError
  end

  # params that will be used to search solutions.
  # Search param can include 'author' (the username of the user who wrote a solution)
  # and 'language' (the name of the language in which a solution is written)
  def search_params
    raise NotImplementedError
  end

  def attachment_param
    raise NotImplementedError
  end

  def find_language
    @language ||=Language.find_by_name(params[:language])
    if @language.nil?
      flash[:danger] = "There is no language #{params[:language]}"
      redirect_back_or new_codeforces_round_solution_path
    end
  end

  def check_upload_perm
    unless can_upload_solution
      if current_user
        flash[:danger] = 'You don\'t have permission to upload a solution.'
        redirect_to_referer_or codeforces_round_solutions_path
      else
        store_location
        flash[:danger] = 'Please login to upload a solution.'
        redirect_to login_path
      end

    end
  end

  def check_delete_perm
    unless can_delete_solution(find_solution)
      store_location
      flash[:danger] = 'You don\'t have permission to delete the solution.'
      redirect_to_referer_or codeforces_round_solutions_path
    end
  end

  def check_edit_perm
    unless can_edit_solution(find_solution)
      store_location
      flash[:danger] = 'You don\'t have permission to edit the solution.'
      redirect_to_referer_or codeforces_round_solutions_path
    end
  end

  def languages
    @languages ||= Language.all
  end

  def filter_author(filtered_params, author_username)
    author = User.find_by_username(author_username)
    filtered_params[:user_id] = author.id if author
    filtered_params.delete(:author)
    author
  end

  def filter_language(filtered_params, language_name)
    language = Language.find_by_name(language_name)
    filtered_params[:language_id] = language if language
    filtered_params.delete(:language)
  end

  def fill_content
    @content = solution_content(find_solution.save_path)

    flash[:danger] = 'Sorry, we are having trouble loading your solution. Please try again later.' unless @content

    # Content could be a zip file in which case we can't properly show content as text file.
    @content = 'Content is not properly encoded (likely a binary/zip file) and therefore cannot be displayed.' if @content && !@content.valid_encoding?
  end

end