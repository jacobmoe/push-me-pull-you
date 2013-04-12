class TasksController < ApplicationController

  before_filter :task_params, :only => [:create, :update]
  before_filter :build_task, :only => [:create]
  before_filter :load_task, :only => [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
  end

  def create
    @task.save!
    redirect_to task_path(@task)
  rescue
    flash.now[:error] = 'Task creation failed. Correct highlighted fields.'
    render :action => :new
  end

  def edit
  end

  def update
    @task.update_attributes!(task_params)
    flash[:notice] = 'Task updated'
    redirect_to :action => :edit
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update task'
    render :action => :edit
  end

  protected

  def task_params
    params.require(:task).permit!
  end

  def build_task
    @task = Task.new(task_params)
  end

  def load_task
    @task = Task.find(params[:id])
  end

end