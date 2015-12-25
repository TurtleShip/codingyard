class SolutionsController < ApplicationController
  # This class contains controller actions common to Controllers that handle solutions.

  PER_PAGE = 30 # Number of solutions to display per page during pagination

  protected

  def find_solution
    raise NotImplementedError
  end

  def find_language
    @language = Language.find_by_name(params[:language])
    if @language.nil?
      flash[:danger] = "There is no language #{params[:language]}"
      redirect_back_or(new_codeforces_round_solution_path)
    end
  end

  def check_upload_perm
    unless can_upload_solution
      store_location
      flash[:danger] = 'Please login to upload a solution.'
      redirect_to login_path
    end
  end

  def check_delete_perm
    unless can_delete_solution(find_solution)
      store_location
      flash[:danger] = 'You don\'t have permission to delete the solution.'
      redirect_to request.referer || codeforces_round_solutions_path
    end
  end

  def check_edit_perm
    unless can_edit_solution(find_solution)
      store_location
      flash[:danger] = 'You don\'t have permission to edit the solution.'
      redirect_to request.referer || codeforces_round_solutions_path
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