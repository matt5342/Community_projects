class SessionsController < ApplicationController
  
  def new
    flash[:notice] = nil
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, errors: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end 
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
