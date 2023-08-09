require "test_helper"

class StudentContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:joel)
    @contact = contacts(:dennis)
  end

  test "should display student_contacts" do
    get student_url(@student)

    assert_response 200

    assert_select 'div.student-contacts' do
      assert_select 'h2', 'Related Contacts'
      assert_select 'table a', 'Dennis'
    end
  end

  test "should get new_contact" do
    get new_contact_relationship_url(@student)
    assert_response :success

    assert_select 'h1', 'New contact for Joel'
    assert_select 'input[type="submit"][value="Assign new contact"]'
  end

  test "should create new student contact" do
    assert_difference('StudentContact.count', 1) do
      post contact_relationships_url(@student), params: default_contact_relationship_params
    end

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', 'Contact was successfully added.'

    assert_select 'div.student-contacts' do
      assert_select 'table a', 'Win'
    end
  end

  test "should fail to create student_contact with missing params" do
    assert_difference('StudentContact.count', 0) do
      post contact_relationships_url(@student), params: {
        student_contact: {
          student_id: '',
          contact_id: '',
          contact_relation: '',
          primary_contact: '',
          account_holder: '',
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New contact for Joel'
    assert_select 'h2', '3 errors prohibited this contact relationship from being saved:'
    assert_select 'li', 'Student must be selected'
    assert_select 'li', 'Contact must be selected'
    assert_select 'li', "Primary contact must be selected"
  end

  test "should fail to create student_contact with existing student/contact combo" do
    dennis_joel = student_contacts(:dennis_joel)
    assert_difference('StudentContact.count', 0) do
      post contact_relationships_url(@student), params: {
        student_contact: {
          student_id: dennis_joel.student_id,
          contact_id: dennis_joel.contact_id,
          primary_contact: false,
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New contact for Joel'
    assert_select 'h2', '2 errors prohibited this contact relationship from being saved:'
    assert_select 'li', 'Student must be selected'
    assert_select 'li', 'Contact must be selected'
  end

  test "should get edit_contact" do
    get edit_contact_relationship_url(student_id: @student, contact_id: @contact)
    assert_response :success

    assert_select 'h1', "Edit 'Dennis' contact relationship with Joel"
    assert_select 'input[name="student_contact[contact_relation]"][value="Dad"]'
    assert_select 'input[type="submit"][value="Update contact relationship"]'
  end

  test "should update contact" do
    dennis_joel = student_contacts(:dennis_joel)
    patch contact_relationship_url(student_id: @student, contact_id: @contact),
      params: {
        student_contact: {
          student_id: dennis_joel.student_id,
          contact_id: dennis_joel.contact_id,
          contact_relation: 'Stepdad',
          primary_contact: dennis_joel.primary_contact,
          account_holder: dennis_joel.account_holder,
        }
      }

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', 'Contact was successfully updated.'
    assert_select 'div.student-contacts' do
      assert_select 'table td', 'Stepdad'
    end
  end

  test "should alert to update without changes" do
    dennis_joel = student_contacts(:dennis_joel)
    patch contact_relationship_url(student_id: @student, contact_id: @contact),
      params: {
        student_contact: {
          student_id: dennis_joel.student_id,
          contact_id: dennis_joel.contact_id,
          contact_relation: dennis_joel.contact_relation,
          primary_contact: dennis_joel.primary_contact,
          account_holder: dennis_joel.account_holder,
        }
      }

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', 'No changes made to contact relationship.'
  end

  test "should fail to update with missing params" do
    patch contact_relationship_url(student_id: @student, contact_id: @contact),
      params: {
        student_contact: {
          student_id: @student.id,
          contact_id: @contact.id,
          contact_relation: '',
          primary_contact: '',
          account_holder: '',
        },
      }

    assert_response 422

    assert_select 'h1', "Edit 'Dennis' contact relationship with Joel"
    assert_select 'h2', '1 error prohibited this contact relationship from being updated:'
    assert_select 'li', "Primary contact must be selected"
  end

  test "should destroy contact relationship" do
    assert_difference('StudentContact.count', -1) do
      delete contact_relationship_url(student_id: @student, contact_id: @contact)
    end

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', 'Contact relationship successfully removed.'
  end

  # test "should get new_student" do
  #   get student_contacts_add_student_url
  #   assert_response :success
  # end

  # test "should get edit_student" do
  #   get student_contacts_edit_student_url
  #   assert_response :success
  # end
end
