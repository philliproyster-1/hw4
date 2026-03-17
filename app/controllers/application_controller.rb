class ApplicationController < ActionController::Base
  before_action :setup_auth
  helper_method :logged_in?, :current_user

  def setup_auth
    if session["user_id"]
      @current_user = User.find_by({ "id" => session["user_id"] })
    end
  end

  def logged_in?
    @current_user.present?
  end

  def current_user
    @current_user
  end

  def require_login
    unless logged_in?
      flash["notice"] = "You must be logged in to do that."
      redirect_to "/login"
    end
  end
end