require 'test_helper'

class ClassifierControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should get classifierresults" do
  	@request.env['HTTP_REFERER'] = 'http://localhost:3000/classifier/'
    get :classifierresults
    assert_response :success
    assert_not_nil assigns(:person)
  end
end
