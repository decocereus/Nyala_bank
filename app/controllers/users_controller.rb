class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def show
    #Searches the database for a user
    @user = User.find(current_user.id)
  end

  def edit
    
  end

end
