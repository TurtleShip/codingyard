class SessionsController < ApplicationController

  def new
  end

  def create
    params = login_params
    @user = User.find_by_username(params[:username])

    if @user && @user.authenticate(params[:password])
      if @user.activated?
        log_in @user
        params[:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = 'Account not activated. Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_params
    params.require(:session)
        .permit(:username, :password, :remember_me)
  end
end
