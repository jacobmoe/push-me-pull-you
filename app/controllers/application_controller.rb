class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  protected

  def not_authenticated
    flash[:error] = 'Please login first'
    redirect_to login_path
  end


end
