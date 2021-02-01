require 'test_helper'

class ChartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get task" do
    get task_url
    assert_response :success
  end
end
