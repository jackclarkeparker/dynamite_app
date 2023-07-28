require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact" do
    assert_difference("Contact.count") do
      post contacts_url, params: { contact: { bank_account: @contact.bank_account, csc_number: @contact.csc_number, email_address: @contact.email_address, entity_id: @contact.entity_id, first_name: @contact.first_name, full_name: @contact.full_name, last_name: @contact.last_name, phone_number: @contact.phone_number, preferred_name: @contact.preferred_name, valid_until: @contact.valid_until } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { bank_account: @contact.bank_account, csc_number: @contact.csc_number, email_address: @contact.email_address, entity_id: @contact.entity_id, first_name: @contact.first_name, full_name: @contact.full_name, last_name: @contact.last_name, phone_number: @contact.phone_number, preferred_name: @contact.preferred_name, valid_until: @contact.valid_until } }
    assert_redirected_to contact_url(@contact)
  end

  test "should destroy contact" do
    assert_difference("Contact.count", -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end
end
