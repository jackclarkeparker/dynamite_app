require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference("Student.count") do
      post students_url, params: { student: { birthday: @student.birthday, first_name: @student.first_name, gender: @student.gender, last_name: @student.last_name, preferred_name: @student.preferred_name, region_id: @student.region_id, year_group: @student.year_group } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { birthday: @student.birthday, first_name: @student.first_name, gender: @student.gender, last_name: @student.last_name, preferred_name: @student.preferred_name, region_id: @student.region_id, year_group: @student.year_group } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    assert_difference("Student.count", -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
