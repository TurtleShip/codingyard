class SessionsController < ApplicationController

  def new
  end

  def create
    params = login_params
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      # Log the user in and redirect to the user's show page.

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
  end

  private

  def login_params
    params.require(:session)
        .permit(:username, :password)
  end
end
