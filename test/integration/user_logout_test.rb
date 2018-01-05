require 'test_helper'

class UserLogoutTestTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:michael)
  end

  test "logout after logged in with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in? 
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url 
    # simulate a user clicking ligout in a different window
    delete logout_path
    follow_redirect! 
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end 

end