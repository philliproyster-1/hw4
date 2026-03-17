class SessionsController < ApplicationController
  def new
    # Renders the login form
  end

  def create
    @user = User.find_by(email: params[:email])
    
    # Check if user exists AND if the decrypted hash matches the inputted password
    if @user && BCrypt::Password.new(@user.password) == params[:password]
      session[:user_id] = @user.id
      redirect_to "/places"
    else
      flash[:notice] = "Incorrect email or password."
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/login"
  end
end