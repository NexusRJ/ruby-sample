require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:jj)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), user: { name: '',
                                    email: 'foo@fake',
                                    password: 'foo',
                                    password_confirmation: 'bar'
                                  }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    name = "jj"
    email = 'jj@jj.com'
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: '' }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test "should redirect edit when not logged in" do
    get edit_user_path id: @user
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to login_url
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "jj"
    email = "jj@jj.com"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "password",
                                    password_confirmation: "password"
                                    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

end
