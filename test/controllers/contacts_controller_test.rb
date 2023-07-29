require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:dennis)
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
      post contacts_url, params: default_contact_params
    end

    assert_redirected_to contact_url(Contact.last)
    follow_redirect!

    assert_select 'p', "Contact was successfully created."
    assert_select 'main div p', /First name:.{5}Cal/m
  end

  test "should create contact with minimum details" do
    assert_difference("Contact.count") do
      post contacts_url, params: {
        contact: {
          region_id: regions(:wellington).id,
          first_name: 'Minnie',
          email_address: 'minnie@email.com',
          last_name: '',
          preferred_name: '',
          phone_number: '',
          bank_account: '',
          csc: '',
        }
      }
    end

    assert_redirected_to contact_url(Contact.last)
    follow_redirect!

    assert_select 'p', "Contact was successfully created."
    assert_select 'main div p', /First name:.{5}Minnie/m
  end

  test "should fail to create contact with missing params" do
    assert_difference("Contact.count", 0) do
      post contacts_url, params: {
        contact: {
          region_id: '',
          first_name: '',
          email_address: '',
          last_name: '',
          preferred_name: '',
          phone_number: '',
          bank_account: '',
          csc: '',
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New contact'
    assert_select 'h2', '3 errors prohibited this contact from being saved:'
    assert_select 'li', 'Region must be selected'
    assert_select 'li', "First name can't be blank"
    assert_select 'li', "Email address can't be blank"
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
    patch contact_url(@contact), params: {
      contact: {
        entity_id: @contact.entity_id,
        region_id: @contact.region_id,
        first_name: @contact.region_id,
        last_name: 'The-Menace',
        preferred_name: @contact.preferred_name,
        email_address: @contact.email_address,
        phone_number: @contact.phone_number,
        bank_account: @contact.bank_account,
        csc_number: @contact.csc_number,
      }
    }

    refute response['Location'] =~ /\/contacts\/#{@contact.id}\z/
    assert response['Location'] =~ /\/contacts\/\d+\z/

    follow_redirect!

    assert_select 'p', "Contact was successfully updated."
    assert_select 'main div p', /Last name:.{5}The-Menace/m
  end

  test "should alert of update without changes" do
    patch contact_url(@contact), params: {
      contact: {
        entity_id: @contact.entity_id,
        region_id: @contact.region_id,
        first_name: @contact.first_name,
        last_name: @contact.last_name,
        preferred_name: @contact.preferred_name,
        email_address: @contact.email_address,
        phone_number: @contact.phone_number,
        bank_account: @contact.bank_account,
        csc_number: @contact.csc_number,
      }
    }

    assert_redirected_to contact_url(@contact)
    follow_redirect!

    assert_select 'p', "No changes made to contact."
  end

  test "should fail to update contact when missing params" do
    patch contact_url(@contact), params: {
      contact: {
        entity_id: @contact.entity_id,
        region_id: @contact.region_id,
        first_name: '',
        last_name: @contact.last_name,
        preferred_name: @contact.preferred_name,
        email_address: @contact.email_address,
        phone_number: @contact.phone_number,
        bank_account: @contact.bank_account,
        csc_number: @contact.csc_number,
      }
    }

    assert_response 422

    assert_select 'h1', 'Editing contact'

    assert_select 'h2', '1 error prohibited this contact from being saved:'
    assert_select 'li', "First name can't be blank"
  end

  test "should destroy contact" do
    assert_difference("Contact.count", -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end
end
