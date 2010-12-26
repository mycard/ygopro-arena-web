require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  setup do
    @notice = notices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notice" do
    assert_difference('Notice.count') do
      post :create, :notice => @notice.attributes
    end

    assert_redirected_to notice_path(assigns(:notice))
  end

  test "should show notice" do
    get :show, :id => @notice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @notice.to_param
    assert_response :success
  end

  test "should update notice" do
    put :update, :id => @notice.to_param, :notice => @notice.attributes
    assert_redirected_to notice_path(assigns(:notice))
  end

  test "should destroy notice" do
    assert_difference('Notice.count', -1) do
      delete :destroy, :id => @notice.to_param
    end

    assert_redirected_to notices_path
  end
end
