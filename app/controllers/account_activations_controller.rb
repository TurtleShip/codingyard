class AccountActivationsController < ApplicationController

  def new
  end

  def create
    email = params.require(:email)
    user = User.find_by_email(email)

    if user
      if user.activated?
        flash[:info] = "User with email #{email} is already activated."
        redirect_back_or(login_path)
      else
        user.create_activation_digest
        user.send_activation_email
        flash[:success] = "Activation email was sent again to email #{email}"
        redirect_back_or(login_path)
      end

    else
      flash[:danger] = "No user was found by email #{email}"
      redirect_back_or(new_account_activation_path)
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user and not user.activated? and user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = 'Account activated :)'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end

end
