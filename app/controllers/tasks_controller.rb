class TasksController < ApplicationController

  before_filter :load_story
  before_filter :task_params, :only => [:create, :update]
  before_filter :build_task, :only => [:create]
  before_filter :load_task, :only => [:edit, :update, :destroy]

  def new
  end

  def create
    @task.save!
    redirect_to stories_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Task creation failed. Correct highlighted fields.'
    render :action => :new
  end

  def edit
  end

  def update
    @task.update_attributes!(task_params)
    flash[:notice] = 'Task updated'
    redirect_to stories_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update task'
    render :action => :edit
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Task deleted'
    redirect_to stories_path
  end

  protected

  def task_params
    params.require(:task).permit!
  end

  def build_task
    @task = @story.tasks.build(task_params)
  end

  def load_task
    @task = Task.find(params[:id])
  end

  def load_story
    @story = Story.find(params[:story_id])
  end

end