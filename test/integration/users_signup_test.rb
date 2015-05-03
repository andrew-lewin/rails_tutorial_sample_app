require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do |element|
      assert_select 'li', 4
    end
    assert_select 'div.alert' do
      assert_select 'div.alert-danger', 'The form contains 4 errors.'
    end
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Example User",
                                           email: "example@example.com",
                                           password: "12341234",
                                           password_confirmation: "12341234" }
    end
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
