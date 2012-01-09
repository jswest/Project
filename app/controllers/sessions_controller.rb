class SessionsController < ApplicationController
  
  def new
    if is_signed_in?
      redirect_to :controller => "users", :action => :show, :id => @current_user.id
    end
  end
  
  def create
    user = User.find_by_email( params[:sessions][:email] )
    if user.nil?
      flash.now[:error] = "Invalid email, dude."
      render 'new'
    else
      sign_in( user )
      redirect_to :controller => "users", :action => :show, :id => @current_user.id
    end
  end
  
  def destroy
    sign_out
    redirect_to :controller => "sessions", :action => :new

  end
  
end