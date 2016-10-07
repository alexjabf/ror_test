require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { active: @user.active, address1: @user.address1, address2: @user.address2, age: @user.age, avatar: @user.avatar, cellphone: @user.cellphone, county: @user.county, email: @user.email, first_name: @user.first_name, is_male: @user.is_male, last_name: @user.last_name, last_name: @user.last_name, phone: @user.phone, username: @user.username, zipcode_id: @user.zipcode_id } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { active: @user.active, address1: @user.address1, address2: @user.address2, age: @user.age, avatar: @user.avatar, cellphone: @user.cellphone, county: @user.county, email: @user.email, first_name: @user.first_name, is_male: @user.is_male, last_name: @user.last_name, last_name: @user.last_name, phone: @user.phone, username: @user.username, zipcode_id: @user.zipcode_id } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
