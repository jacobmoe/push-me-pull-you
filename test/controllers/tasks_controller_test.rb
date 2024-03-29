require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  def setup
    login_user(@user = users(:one))
    @story = stories(:one)
    @task = tasks(:one)
  end

  def test_get_new
    get :new, :story_id => @story
    assert_response :success
    assert_template :new
  end

  def test_get_new_not_logged_in
    logout_user
    get :new, :story_id => @story
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_creation
    assert_difference 'Task.count' do
      post :create, :story_id => @story, :task => {
        :description => 'test task description'
      }
      assert_response :redirect
      assert assigns(:task)
      assert_redirected_to stories_path
    end
  end

  def test_creation_failure
    assert_no_difference 'Task.count' do
      post :create, :story_id => @story, :task => { 
        :description => ''
      }
      assert_response :success
      assert_template :new
      assert_equal 'Task creation failed. Correct highlighted fields.', flash[:error]
    end
  end

  def test_get_edit
    get :edit, :story_id => @story, :id => @task
    assert assigns(:task)
    assert_response :success
    assert_template :edit
  end

  def test_get_edit_when_not_logged_in
    logout_user
    get :edit, :story_id => @story, :id => @task
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_update
    put :update, :story_id => @story, :id => @task, :task => {
      :description => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to stories_path
    assert_equal 'Task updated', flash[:notice]
    @task.reload
    assert_equal 'Updated', @task.description
  end
  
  def test_update_failure
    task = tasks(:one)
    put :update, :story_id => @story, :id => task, :task => {
      :description => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update task', flash[:error]
    task.reload
    assert_not_equal '', task.description
  end

  def test_destroy
    assert_difference 'Task.count', -1 do
      delete :destroy, :story_id => @story, :id => @task
      assert_response :redirect
      assert_redirected_to stories_path
      assert_equal 'Task deleted', flash[:notice]
    end
  end

end
