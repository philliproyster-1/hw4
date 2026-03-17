class UsersController < ApplicationController
  def new
    # Renders the sign-up form
  end

  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    
    # 1-way encrypted hash using Bcrypt (Rubric Requirement)
    @user.password = BCrypt::Password.create(params[:password])
    
    if @user.save
      redirect_to "/login" 
    else
      render :new
    end
  end
end