module SolutionsHelper

  def can_upload?
    unless logged_in?
      store_location
      flash[:danger] = 'Please login to upload a solution.'
      redirect_to login_url
    end
  end

end