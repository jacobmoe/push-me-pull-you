class StoriesController < ApplicationController

  before_filter :story_params, :only => [:create, :update]
  before_filter :build_story, :only => [:create]
  before_filter :load_story, :only => [:show, :edit, :update, :destroy, :push]

  def index
    @users = User.all
    @stories = Story.all
  end

  def new
  end

  def create
    @story.save!
    redirect_to stories_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Story creation failed. Correct highlighted fields.'
    render :action => :new
  end

  def edit
  end

  def update
    @story.update_attributes!(story_params)
    flash[:notice] = 'Story updated'
    redirect_to stories_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update story'
    render :action => :edit
  end

  def destroy
    @story.destroy
    flash[:notice] = 'Story deleted'
    redirect_to stories_path
  end

  def push
    if params[:user][:id].present?
      user = User.find(params[:user][:id])
      @story.push(user)
      if user == current_user
        flash[:notice] = 'Story pulled'
      else
        flash[:notice] = "Story pushed towards #{user.username}"
      end
    end
    redirect_to stories_path
  end

  protected

  def story_params
    params.require(:story).permit!
  end

  def build_story
    @story = Story.new(story_params)
  end

  def load_story
    @story = Story.find(params[:id])
  end

end