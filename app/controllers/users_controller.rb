class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to CodingYard!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Your profile has been successfully updated.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user)
          .permit(:username, :email, :firstname, :lastname,
                  :password, :password_confirmation)
    end

    # Method for before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end


end
