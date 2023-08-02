require "test_helper"

class StudentContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get add_contact" do
    get student_contacts_add_contact_url
    assert_response :success
  end

  test "should get add_student" do
    get student_contacts_add_student_url
    assert_response :success
  end

  test "should get edit_contact" do
    get student_contacts_edit_contact_url
    assert_response :success
  end

  test "should get edit_student" do
    get student_contacts_edit_student_url
    assert_response :success
  end
end
