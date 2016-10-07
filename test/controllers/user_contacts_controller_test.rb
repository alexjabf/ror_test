require 'test_helper'

class UserContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_contact = user_contacts(:one)
  end

  test "should get index" do
    get user_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_user_contact_url
    assert_response :success
  end

  test "should create user_contact" do
    assert_difference('UserContact.count') do
      post user_contacts_url, params: { user_contact: { address: @user_contact.address, email: @user_contact.email, name: @user_contact.name, phone: @user_contact.phone, user_id: @user_contact.user_id } }
    end

    assert_redirected_to user_contact_url(UserContact.last)
  end

  test "should show user_contact" do
    get user_contact_url(@user_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_contact_url(@user_contact)
    assert_response :success
  end

  test "should update user_contact" do
    patch user_contact_url(@user_contact), params: { user_contact: { address: @user_contact.address, email: @user_contact.email, name: @user_contact.name, phone: @user_contact.phone, user_id: @user_contact.user_id } }
    assert_redirected_to user_contact_url(@user_contact)
  end

  test "should destroy user_contact" do
    assert_difference('UserContact.count', -1) do
      delete user_contact_url(@user_contact)
    end

    assert_redirected_to user_contacts_url
  end
end
