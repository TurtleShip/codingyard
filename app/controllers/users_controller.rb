class UsersController < ApplicationController

  helper_method :required_field?, :password_field?, :email_field?, :user_fields

  before_action :check_edit_perm, only: [:edit, :update]
  before_action :check_delete_perm, only: [:destroy]

  def index
    @users = User.where(activated: true)
                 .paginate(page: params[:page], :per_page => User::PER_PAGE)
  end

  def show
    @user = target_user
    redirect_to root_url unless @user.activated?

    @user_basic_info = {
        firstname: @user.firstname,
        lastname: @user.lastname,
        'Codeforces Handle': @user.codeforces_handle,
        'TopCoder Handle': @user.topcoder_handle,
        'UVa Handle': @user.uva_handle
    }

    # A user's email will be only visible to itself and the admin for privacy reasons.
    if logged_in? && (current_user?(@user) || current_user.admin?)
      @user_basic_info[:email] = @user.email
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account. It may be in your junk folder.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = target_user
  end

  def update
    @user = target_user
    if @user.update_attributes(user_params)
      flash[:success] = 'Your profile has been successfully updated.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    target_user.destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def user_fields
    @user_fields ||= required_fields + optional_fields
    @user_fields.to_a
  end

  def required_field?(form_field)
    required_fields.include? form_field
  end

  def password_field?(form_field)
    password_fields.include? form_field
  end

  def email_field?(form_field)
    email_fields.include? form_field
  end

  private
  def user_params
    params.require(:user)
        .permit(user_fields)
  end

  def required_fields
    @required_fields ||= Set.new [:username, :email, :password, :password_confirmation]
  end

  def optional_fields
    @optional_fields ||= Set.new [:firstname, :lastname, :codeforces_handle, :topcoder_handle, :uva_handle]
  end

  def password_fields
    @password_fields ||= Set.new [:password, :password_confirmation]
  end

  def email_fields
    @email_fields ||= Set.new [:email]
  end

  def check_edit_perm
    unless can_edit_user target_user
      flash[:error] = "You don't have permission to edit #{target_user.username}"
      if current_user
        redirect_back_or(users_path)
      else # Not logged in, so redirect to login page
        store_location
        redirect_to login_path
      end
    end
  end

  def check_delete_perm
    unless can_delete_user target_user
      flash[:error] = "You don't have permission to delete #{target_user.username}"
      if current_user
        redirect_back_or(users_path)
      else
        store_location
        redirect_back_or(login_path)
      end
    end
  end

  def target_user
    @user ||= User.find(params[:id])
  end

end
