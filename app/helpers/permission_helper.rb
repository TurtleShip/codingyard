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
    logged_in? # Any one who is logged in can upload solution
  end

  def can_delete_solution(solution)
    logged_in? && (solution.user == current_user || current_user.admin?)
  end

  def can_edit_solution(solution)
    logged_in? && (solution.user == current_user || current_user.admin?)
  end

  def can_vote
    logged_in?
  end

end
