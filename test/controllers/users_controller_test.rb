require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    login_user(@user = users(:one))
  end

  def test_get_new
    get :new
    assert_response :success
    assert_template :new
    assert_select 'form[action=/signup]'
  end

  def test_creation
    assert_difference 'User.count' do
      post :create, :user => {
        :username => 'test user',
        :email => 'test@example.com',
        :password => 'pass'
      }
      assert_response :redirect
      assert assigns(:user)
      assert_redirected_to user_path(assigns(:user))
    end
  end

  def test_creation_failure
    assert_no_difference 'User.count' do
      post :create, :user => { 
        :username => '',
        :email => ''
      }
      assert_response :success
      assert_template :new
      assert_equal 'Registration failed. Correct highlighted fields.', flash[:error]
    end
  end

  def test_get_show
    get :show, :id => @user
    assert assigns(:user)
    assert_response :success
    assert_template :show
  end

  def test_get_show_when_not_logged_in
    logout_user
    get :show, :id => @user
    assert_response :redirect
    assert_redirected_to login_path
  end

  def test_get_edit
    get :edit, :id => @user
    assert assigns(:user)
    assert_response :success
    assert_template :edit
  end

  def test_get_edit_failure
    logout_user
    get :edit, :id => @user
    assert_response :redirect
    assert_redirected_to login_path
    assert_equal 'Please login first', flash[:error]
  end

  def test_update
    put :update, :id => @user, :user => {
      :username => 'Updated',
      :email => @user.email,
      :password => 'pass',
      :password_confirmation => 'pass'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit
    assert_equal 'Profile information updated', flash[:notice]
    @user.reload
    assert_equal 'Updated', @user.username
  end
  
  def test_update_failure
    user = users(:one)
    put :update, :id => user, :user => {
      :username => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update profile information', flash[:error]
    user.reload
    assert_not_equal '', user.username
  end




end
