require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "param test" do
    get User.all
    assert_response :success
  end

end