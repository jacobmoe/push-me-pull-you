require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  def test_get_new
    get :new
    assert_response :success
    assert_template :new
  end

  def test_creation
    user = users(:one)
    post :create, :session => {
      :username => user.username,
      :password => 'passpass'
    }
    assert_response :redirect
    assert_redirected_to user_path(user)
    assert assigns(:user)
    assert_equal users(:one), assigns(:current_user)
  end

  def test_creation_failure
    post :create, :session => {
      :username => 'not a user',
      :password => 'not the password'
    }
    assert_response :success
    assert_equal 'Invalid credentials', flash.now[:error]
    assert !assigns(:user)
  end

  def test_destroy
    login_user(users(:one))
    delete :destroy
    assert_response :redirect
    assert_redirected_to '/'
    assert_nil assigns(:current_user)
  end

end
