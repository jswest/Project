class SessionsController < ApplicationController
  
  def new
    if is_signed_in?
      redirect_to :controller => 'user', :action => 'show'
    end
  end
  
  def create
    user = User.where( :username => params[:username] )
    if user.nil?
      flash.now[:error] = "Invalid username, dude."
      render 'new'
    else
      sign_in( user )
      redirect to user
    end
  end
  
  def destroy
    sign_out
    redirect_to "/"
  end
  
end