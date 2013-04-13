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
    assert_difference 'Story.count' do
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
    assert_difference 'Story.count', -1 do
      delete :destroy, :id => @story
      assert_response :redirect
      assert_redirected_to stories_path
      assert_equal 'Story deleted', flash[:notice]
    end
  end

end
