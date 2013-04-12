require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  def setup
    login_user(@user = users(:one))
    @task = tasks(:one)
  end

  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:tasks)
    assert_equal 2, assigns(:tasks).count
  end

  def test_get_new
    get :new
    assert_response :success
    assert_template :new
  end

  def test_get_new_not_logged_in
    logout_user
    get :new
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_creation
    assert_difference 'Task.count' do
      post :create, :task => {
        :title => 'test task',
        :description => 'test task description',
        :length => 1
      }
      assert_response :redirect
      assert assigns(:task)
      assert_redirected_to task_path(assigns(:task))
    end
  end

  def test_creation_failure
    assert_no_difference 'Task.count' do
      post :create, :task => { 
        :title => '',
        :description => ''
      }
      assert_response :success
      assert_template :new
      assert_equal 'Task creation failed. Correct highlighted fields.', flash[:error]
    end
  end

  def test_get_show
    get :show, :id => @task
    assert assigns(:task)
    assert_response :success
    assert_template :show
  end

  def test_get_show_when_not_logged_in
    logout_user
    get :show, :id => @task
    assert_response :redirect
    assert_redirected_to login_path
  end

  def test_get_edit
    get :edit, :id => @task
    assert assigns(:task)
    assert_response :success
    assert_template :edit
  end

  def test_get_edit_when_not_logged_in
    logout_user
    get :edit, :id => @task
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_update
    put :update, :id => @task, :task => {
      :title => 'Updated',
      :description => @task.description
    }
    assert_response :redirect
    assert_redirected_to :action => :edit
    assert_equal 'Task updated', flash[:notice]
    @task.reload
    assert_equal 'Updated', @task.title
  end
  
  def test_update_failure
    task = tasks(:one)
    put :update, :id => task, :task => {
      :description => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update task', flash[:error]
    task.reload
    assert_not_equal '', task.description
  end

end
