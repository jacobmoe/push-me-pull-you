require 'test_helper'

class StoriesControllerTest < ActionController::TestCase

  def setup
    login_user(@user = users(:one))
    @story = stories(:one)
  end

  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:stories)
    assert_equal 2, assigns(:stories).count
    assert assigns(:users)
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
    assert_difference ['Story.count'] do
      post :create, :story => {
        :description => 'test story description',
        :estimate => 1
      }
      assert_response :redirect
      assert assigns(:story)
      assert_redirected_to stories_path
    end
  end

  def test_creation_failure
    assert_no_difference 'Story.count' do
      post :create, :story => { 
        :description => ''
      }
      assert_response :success
      assert_template :new
      assert_equal 'Story creation failed. Correct highlighted fields.', flash[:error]
    end
  end

  def test_get_edit
    get :edit, :id => @story
    assert assigns(:story)
    assert_response :success
    assert_template :edit
  end

  def test_get_edit_when_not_logged_in
    logout_user
    get :edit, :id => @story
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_update
    put :update, :id => @story, :story => {
      :description => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to stories_path
    assert_equal 'Story updated', flash[:notice]
    @story.reload
    assert_equal 'Updated', @story.description
  end
  
  def test_update_failure
    story = stories(:one)
    put :update, :id => story, :story => {
      :description => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update story', flash[:error]
    story.reload
    assert_not_equal '', story.description
  end

  def test_destroy
    @user.stories << @story
    @user.save
    assert_equal 1, @story.tasks.count
    assert_equal 1, @story.user_stories.count
    assert_difference ['Story.count', 'Task.count', 'UserStory.count'], -1 do
      delete :destroy, :id => @story
      assert_response :redirect
      assert_redirected_to stories_path
      assert_equal 'Story deleted', flash[:notice]
    end
  end

  def test_push
    user = users(:two)
    user.stories << @story
    user.save

    user_story = @story.user_stories.where(:user_id => user).first
    assert_equal 0, user_story.distance

    post :push, {
      :id => @story, 
      :user => {
        :id => user
      }
    }

    user_story.reload
    assert_equal 1, user_story.distance
    assert_equal "Story pushed towards #{user.username}", flash[:notice]
  end

  def test_pull
    @user.stories << @story
    @user.save

    user_story = @story.user_stories.where(:user_id => @user).first
    assert_equal 0, user_story.distance

    post :push, {
      :id => @story, 
      :user => {
        :id => @user
      }
    }

    user_story.reload
    assert_equal 1, user_story.distance
    assert_equal 'Story pulled', flash[:notice]
  end


end
