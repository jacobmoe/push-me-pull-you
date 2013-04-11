class UserSessionsController < ApplicationController

  skip_before_filter :require_login, :except => [:destroy]

  def new
    render
  end

  def create
    if @user = login(params[:session][:username], params[:session][:password])
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'Invalid credentials'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
