require 'test_helper'

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get checkout_view_url
    assert_response :success
  end

end
