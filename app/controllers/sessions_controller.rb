class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    p user
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user_path(user)
    else
      flash.now[:alert] = "ASDASDSAD"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logget out"
    redirect_to login_path
  end
end
