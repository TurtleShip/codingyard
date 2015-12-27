class SolutionsController < ApplicationController
  # This class contains controller actions common to Controllers that handle solutions.
  # Take a look at CodeforcesRoundSolutionsController for a use case of this controller.

  PER_PAGE = 30 # Number of solutions to display per page during pagination
  UPLOAD_SIZE_LIMIT = 1.megabytes

  before_action :find_solution, only: [:show, :edit, :update, :destroy, :download, :like, :dislike, :cancel_vote]
  before_action :languages, only: [:new, :create, :show, :edit, :update, :index]
  before_action :find_language, only: [:create]
  before_action :has_required_params_for_create, only: [:create]
  before_action :check_upload_perm, only: [:new, :create]
  before_action :check_delete_perm, only: [:destroy]
  before_action :check_edit_perm, only: [:edit, :update]
  before_action :check_vote_perm, only: [:like, :dislike, :cancel_vote]

  def index
    filtered_params = search_params.reject { |key, value| value.blank? }

    @warnings = []
    author_username = filtered_params[:author]
    if author_username.present? && !filter_author(filtered_params, author_username)
      @warnings << "No user found by name '#{author_username}', so the author field is ignored."
    end

    language_name = filtered_params[:language]
    if language_name.present? && !filter_language(filtered_params, language_name)
      @warnings << "#{language_name} is not registered yet, so the language field is ignored."
    end

    assign_to_index_variable solution_class
                     .where(filtered_params)
                     .paginate(page: params[:page], :per_page => PER_PAGE)
  end

  def show
    @solution_info = solution_info
    fill_content # Content of the solution will be available as @content
  end

  def new
    @solution = solution_class.new
    @is_new = true
    @supported_file_types = Language.get_all_extensions_concat
  end

  def create
    @solution = solution_class.new_with_relations(solution_params, current_user, @language)

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
    redirect_to action: :index
  end

  def download
    send_data solution_content(@solution.save_path), disposition: 'attachment', filename: @solution.save_path.split('/').last
  end

  def like
    @solution.liked_by current_user
    flash[:success] = "You liked solution #{@solution.id}"
    redirect_back_or @solution
  end

  def dislike
    @solution.disliked_by current_user
    flash[:success] = "You disliked solution #{@solution.id}"
    redirect_back_or @solution
  end

  def cancel_vote
    @solution.unvote_by current_user
    flash[:success] = "You canceled your vote for solution #{@solution.id}"
    redirect_back_or @solution
  end

  protected

  def solution_class
    raise NotImplementedError
  end

  # filter parameters required/permitted for the solution this controller is handling.
  def solution_params
    raise NotImplementedError
  end

  # params that will be used to search solutions.
  # Note that search params keys with nil or '' will be ignored.
  # Search param can include 'author' (the username of the user who wrote a solution)
  # and 'language' (the name of the language in which a solution is written)
  def search_params
    raise NotImplementedError
  end

  def attachment_param
    raise NotImplementedError
  end

  # A hash map containing <key,value> = <attribute_name, attribute_value> that you want
  # to show to users for a specific solution.
  # The caller of this method can assume that the solution to be displayed is available in scope
  # as @solution.
  # The hash map will be available in view as @solution_info
  def solution_info
    raise NotImplementedError
  end

  # Assign given solutions to an instance variable to be used in index view.
  # will_paginate gem requires to name an instance variable as plural of the current solutions.
  # ex> @codeforces_round_solutions, @top_coder_srm_solutions
  def assign_to_index_variable(solutions)
    raise NotImplementedError
  end

  def find_solution
    @solution ||= solution_class.find_by_id(params[:id])
    if @solution.nil?
      flash[:danger] = "There is no solution #{params[:id]}"
      redirect_back_or(codeforces_round_solutions_path)
    else
      @solution
    end
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

  def check_vote_perm
    unless can_vote
      store_location
      flash[:danger] = 'You don\'t have permission to vote a solution.'
      redirect_to_referer_or @solution
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

  def has_required_params_for_create
    @solution = solution_class.new
    if params.blank?
      @solution.errors.add(:parameters, 'must be provided')
    else
      tmp_params = params[solution_class.to_s.underscore]
      if tmp_params.blank?
        @solution.errors.add(:parameters, "missing values for #{solution_class.to_s.underscore}")
      else
        @solution.errors.add(:attachment, 'must be provided') unless tmp_params[:attachment].present?
      end
      @solution.errors.add(:language, 'must be specified') unless params[:language].present?
    end

    render :new unless @solution.errors.empty?
  end

end