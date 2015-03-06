require 'test_helper'

class ClassifierControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should redirect cause of if statements" do
  	@request.env['HTTP_REFERER'] = 'http://localhost:3000/classifier'
    get(:classifierresults, {'height' => 600}, {'weight' => 100})
    assert_response :redirect, @response.body
    #assert_not_nil assigns(:person)
  end
end
