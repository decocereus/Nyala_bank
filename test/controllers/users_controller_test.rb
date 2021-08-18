require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "index test" do
    get users_url
    assert_response :success
  end

  test "show test" do
    user = user(:userTest)
    get user_url(userTest)
    assert_response :success
  end

end