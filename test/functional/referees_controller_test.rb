require 'test_helper'

class RefereesControllerTest < ActionController::TestCase
  setup do
    @referee = referees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referee" do
    assert_difference('Referee.count') do
      post :create, referee: {  }
    end

    assert_redirected_to referee_path(assigns(:referee))
  end

  test "should show referee" do
    get :show, id: @referee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @referee
    assert_response :success
  end

  test "should update referee" do
    put :update, id: @referee, referee: {  }
    assert_redirected_to referee_path(assigns(:referee))
  end

  test "should destroy referee" do
    assert_difference('Referee.count', -1) do
      delete :destroy, id: @referee
    end

    assert_redirected_to referees_path
  end
end
