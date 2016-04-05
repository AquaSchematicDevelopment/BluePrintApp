require 'test_helper'

class SeasonalPerformancesControllerTest < ActionController::TestCase
  setup do
    @seasonal_performance = seasonal_performances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seasonal_performances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seasonal_performance" do
    assert_difference('SeasonalPerformance.count') do
      post :create, seasonal_performance: { book_value: @seasonal_performance.book_value, season_id: @seasonal_performance.season_id, team_id: @seasonal_performance.team_id }
    end

    assert_redirected_to seasonal_performance_path(assigns(:seasonal_performance))
  end

  test "should show seasonal_performance" do
    get :show, id: @seasonal_performance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seasonal_performance
    assert_response :success
  end

  test "should update seasonal_performance" do
    patch :update, id: @seasonal_performance, seasonal_performance: { book_value: @seasonal_performance.book_value, season_id: @seasonal_performance.season_id, team_id: @seasonal_performance.team_id }
    assert_redirected_to seasonal_performance_path(assigns(:seasonal_performance))
  end

  test "should destroy seasonal_performance" do
    assert_difference('SeasonalPerformance.count', -1) do
      delete :destroy, id: @seasonal_performance
    end

    assert_redirected_to seasonal_performances_path
  end
end
