require 'test_helper'

class ModcpControllerTest < ActionController::TestCase
  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get displayorder" do
    get :displayorder
    assert_response :success
  end

  test "should get highlight" do
    get :highlight
    assert_response :success
  end

  test "should get digest" do
    get :digest
    assert_response :success
  end

  test "should get lock" do
    get :lock
    assert_response :success
  end

  test "should get move" do
    get :move
    assert_response :success
  end

  test "should get merge" do
    get :merge
    assert_response :success
  end

  test "should get split" do
    get :split
    assert_response :success
  end

end
