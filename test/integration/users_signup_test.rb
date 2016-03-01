require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                             email: "user@fake",
                             password: "fuck",
                             password_confirmation: "again",
                            }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    name = "jaja"
    email = "jaja@binks.nab"
    password = "password"
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: name,
                                            email: email,
                                            password: password,
                                            password_confirmation: password
                                      }
    end
    assert_template 'users/show'
end
end
