class UsersController < ApplicationController
  # force_ssl
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
    
  end

  def search
    respond_to do |format|
      format.json {
        render :json => User.all.map{ |u|
          {
          :value => "#{u.firstname.capitalize if u.firstname} #{u.lastname.capitalize if u.lastname} <#{u.email}>",
          :id => u.id
          }
        }
      }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render @user }
    end
  end

  def new
    if is_signed_in?
      return redirect_to :controller => "front_page", :action => "index"
    end
    
    @user = User.new
    
    respond_to do |format|
      format.html { render :layout => "index" }
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save!
        sign_in( @user )
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
