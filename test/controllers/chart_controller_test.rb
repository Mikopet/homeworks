require 'test_helper'

class ChartControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get chart_show_url
    assert_response :success
  end

end
