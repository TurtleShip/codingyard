module PermissionHelper

  # Returns true if current user can edit the given user. False otherwise.
  def can_edit_user(user)
    return false unless current_user # User must be logged in
    current_user?(user) # Only the user itself can edit its info
  end

  # Returns true if current user can delete the given user. False otherwise.
  def can_delete_user(user)
    return false unless current_user # User must be logged in
    return false if user.admin? # An admin cannot be deleted
    current_user.admin? # only admin can delete members
  end

  def can_upload_solution
    unless logged_in?
      store_location
      flash[:danger] = 'Please login to upload a solution.'
      redirect_to login_url
    end
  end

  def can_delete_solution
    unless logged_in? && (@solution.user == current_user || current_user.admin?)
      store_location
      flash[:danger] = 'You don\'t have permission to delete the solution.'
      redirect_to (request.referer || root_url)
    end
  end

  def can_edit_solution
    unless logged_in? && (@solution.user == current_user || current_user.admin?)
      store_location
      flash[:danger] = 'You don\'t have permission to edit the solution.'
      redirect_to (request.referer || root_url)
    end
  end

end
