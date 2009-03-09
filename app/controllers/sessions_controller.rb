class SessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    email_address = params[:user][:email_address]
    password = params[:user][:password]
    user = User.find_by_email_address_and_password(email_address, password)

    if user
      session[:user_id] = user.id

      stored_redirect_url = session[:redirect_to]
      if stored_redirect_url
        session[:redirect_to] = nil
        redirect_to stored_redirect_url
      else
        redirect_to root_url
      end
    else
      flash.now[:notice] = "User and password not found. Please try again."
      render :template => 'sessions/new'
    end
  end
end