require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:jj)
    @other_user = users(:zhang3)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id:@user, user: { name: @user.name, email: @user.email }
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password: 'password',
                                            password_confirmation: 'password',
                                            admin: false}
    assert_not @other_user.false.admin?
  end

end
