require 'test_helper'

class SellRequestsControllerTest < ActionController::TestCase
  setup do
    @sell_request = sell_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sell_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sell_request" do
    assert_difference('SellRequest.count') do
      post :create, sell_request: { amount: @sell_request.amount, price: @sell_request.price }
    end

    assert_redirected_to sell_request_path(assigns(:sell_request))
  end

  test "should show sell_request" do
    get :show, id: @sell_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sell_request
    assert_response :success
  end

  test "should update sell_request" do
    patch :update, id: @sell_request, sell_request: { amount: @sell_request.amount, price: @sell_request.price }
    assert_redirected_to sell_request_path(assigns(:sell_request))
  end

  test "should destroy sell_request" do
    assert_difference('SellRequest.count', -1) do
      delete :destroy, id: @sell_request
    end

    assert_redirected_to sell_requests_path
  end
end
