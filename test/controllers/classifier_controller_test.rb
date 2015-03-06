require 'test_helper'

class ClassifierControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should get classifierresults" do
    get :classifierresults
    assert_response :success
  end
end
