require 'test_helper'

class ModerationsControllerTest < ActionController::TestCase
  setup do
    @moderation = moderations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moderations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create moderation" do
    assert_difference('Moderation.count') do
      post :create, :moderation => @moderation.attributes
    end

    assert_redirected_to moderation_path(assigns(:moderation))
  end

  test "should show moderation" do
    get :show, :id => @moderation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @moderation.to_param
    assert_response :success
  end

  test "should update moderation" do
    put :update, :id => @moderation.to_param, :moderation => @moderation.attributes
    assert_redirected_to moderation_path(assigns(:moderation))
  end

  test "should destroy moderation" do
    assert_difference('Moderation.count', -1) do
      delete :destroy, :id => @moderation.to_param
    end

    assert_redirected_to moderations_path
  end
end
