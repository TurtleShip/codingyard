class UsersController < ApplicationController

  before_action :check_edit_perm, only: [:edit, :update]
  before_action :check_delete_perm, only: [:destroy]


  def index
    @users = User.where(activated: true)
                 .paginate(page: params[:page], :per_page => User::PER_PAGE)
  end

  def show
    @user = target_user
    redirect_to root_url unless @user.activated?

    @user_basic_info = {}

    # A user's email will be only visible to itself and the admin for privacy reasons.
    if logged_in? && (current_user?(@user) || current_user.admin?)
      @user_basic_info[:email] = @user.email
    end

    @user_basic_info.merge!({
        firstname: @user.firstname,
        lastname: @user.lastname
    })
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

  private
    def user_params
      params.require(:user)
          .permit(:username, :email, :firstname, :lastname,
                  :password, :password_confirmation)
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
