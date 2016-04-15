require 'test_helper'

class BuyRequestsControllerTest < ActionController::TestCase
  setup do
    @buy_request = buy_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buy_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buy_request" do
    assert_difference('BuyRequest.count') do
      post :create, buy_request: { amount: @buy_request.amount, price: @buy_request.price }
    end

    assert_redirected_to buy_request_path(assigns(:buy_request))
  end

  test "should show buy_request" do
    get :show, id: @buy_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buy_request
    assert_response :success
  end

  test "should update buy_request" do
    patch :update, id: @buy_request, buy_request: { amount: @buy_request.amount, price: @buy_request.price }
    assert_redirected_to buy_request_path(assigns(:buy_request))
  end

  test "should destroy buy_request" do
    assert_difference('BuyRequest.count', -1) do
      delete :destroy, id: @buy_request
    end

    assert_redirected_to buy_requests_path
  end
end
