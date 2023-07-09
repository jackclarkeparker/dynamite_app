require "test_helper"

class TutorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tutor = tutors(:one)
  end

  test "should get index" do
    get tutors_url
    assert_response :success
  end

  test "should get new" do
    get new_tutor_url
    assert_response :success
  end

  test "should create tutor" do
    assert_difference("Tutor.count") do
      post tutors_url, params: { tutor: { email_address: @tutor.email_address, first_name: @tutor.first_name, last_name: @tutor.last_name, mail_address: @tutor.mail_address, phone_number: @tutor.phone_number, preferred_name: @tutor.preferred_name } }
    end

    assert_redirected_to tutor_url(Tutor.last)
  end

  test "should show tutor" do
    get tutor_url(@tutor)
    assert_response :success
  end

  test "should get edit" do
    get edit_tutor_url(@tutor)
    assert_response :success
  end

  test "should update tutor" do
    patch tutor_url(@tutor), params: { tutor: { email_address: @tutor.email_address, first_name: @tutor.first_name, last_name: @tutor.last_name, mail_address: @tutor.mail_address, phone_number: @tutor.phone_number, preferred_name: @tutor.preferred_name } }
    assert_redirected_to tutor_url(@tutor)
  end

  test "should destroy tutor" do
    assert_difference("Tutor.count", -1) do
      delete tutor_url(@tutor)
    end

    assert_redirected_to tutors_url
  end
end
