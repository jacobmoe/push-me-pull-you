class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :user_params, :only => [:create, :update]
  before_filter :build_user, :only => [:create]
  before_filter :load_user, :only => [:show, :edit, :update, :destroy, :add_all_stories]

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
    @user.save!
    auto_login(@user)
    redirect_to user_path(@user)
  rescue
    flash.now[:error] = 'Registration failed. Correct highlighted fields.'
    render :action => :new
  end

  def edit
  end

  def update
    @user.update_attributes!(user_params)
    flash[:notice] = 'Profile information updated'
    redirect_to :action => :edit
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update profile information'
    render :action => :edit
  end

  def add_all_stories
    @user.add_all_stories
    flash[:notice] = "Stories added to #{@user.username}"
    redirect_to users_path
  end

  protected

  def user_params
    params.require(:user).permit!
  end

  def build_user
    @user = User.new(user_params)
  end

  def load_user
    @user = current_user
  end

end
