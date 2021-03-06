require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "signup failure" do 

    user_hash = {
      name: "",
      email: "user@invalid",
      password: "foo",
      password_confirmation: "bar"
    }

    get signup_path

    assert_no_difference 'User.count' do
      post users_path, params: { user: user_hash }
    end 
    
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    
  end 

  test "signup success" do 

    user_hash = {
      name: "Valid User",
      email: "user@valid.com",
      password: "foobar123",
      password_confirmation: "foobar123"
    }

    get signup_path

    assert_difference 'User.count', 1 do
      post users_path, params: { user: user_hash }
    end 

    follow_redirect! 
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  
  end

end
