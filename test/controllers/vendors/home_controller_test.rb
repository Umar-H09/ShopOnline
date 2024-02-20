require "test_helper"

class Vendors::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vendors_home_index_url
    assert_response :success
  end
end
