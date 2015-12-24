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

end
