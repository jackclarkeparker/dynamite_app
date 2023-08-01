require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:joel)
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
    assert_difference("Student.count", 1) do
      post students_url, params: default_student_params
    end

    assert_redirected_to student_url(Student.last)
    follow_redirect!

    assert_select 'p', 'Student was successfully created.'
    assert_select 'main div p', /First name:.{5}Arya/m
  end

  test "should create student when non-required params are omitted" do
    params = default_student_params
    params[:student][:last_name] = ''
    params[:student][:preferred_name] = ''
    params[:student][:year_group] = ''
    params[:student][:birthday] = ''
    params[:student][:gender] = ''
    params[:student][:keyboard] = ''

    assert_difference("Student.count", 1) do
      post students_url, params: params
    end

    assert_redirected_to student_url(Student.last)
    follow_redirect!

    assert_select 'p', 'Student was successfully created.'

    form_div = css_select("main div#student_#{Student.last.id}")
    assert (css_select(form_div, 'p').any? do |para|
      para.text =~ /\A\s*Birthday:\s*\z/
    end)
  end

  test "should fail to create student with missing params" do
    assert_difference("Student.count", 0) do
      post students_url, params: {
        student: {
          first_name: '',
          last_name: '',
          preferred_name: '',
          age: '',
          birthday: nil,
          year_group: '',
          gender: '',
          region_id: '',
          keyboard: 'Unknown',
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New student'
    assert_select 'h2', '3 errors prohibited this student from being saved:'
    assert_select 'li', "First name can't be blank"
    assert_select 'li', "Age can't be blank"
    assert_select 'li', 'Region must be selected'
  end

  test "Should fail to create student with invalid input values" do
    params = default_student_params
    params[:student][:region_id] = 123456789
    params[:student][:gender] = 'noodle'
    params[:student][:year_group] = -300
    params[:student][:birthday] = '2300-04-13'
    params[:student][:age] = 3

    post students_url, params: params

    assert_response 422

    assert_select 'h1', 'New student'
    assert_select 'h2', '5 errors prohibited this student from being saved:'
    assert_select 'li', 'Region must be selected'
    assert_select 'li', 'Gender must be selected'
    assert_select 'li', 'Year group cannot be less than 1, or greater than 13'
    assert_select 'li', "Birthday can't be less than two years ago"
    assert_select 'li', "Age must be greater than three"
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
    patch student_url(@student), params: {
      student: {
        birthday: '2015-10-8',
        first_name: @student.first_name,
        gender: @student.gender,
        last_name: @student.last_name,
        preferred_name: @student.preferred_name,
        region_id: @student.region_id,
        year_group: @student.year_group,
      }
    }

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', "Student was successfully updated."
    assert_select 'main div p', /Birthday:.{5}2015-10-08/m
  end

  test "should alert of update without changes" do
    patch student_url(@student), params: {
      student: {
        age: @student.age,
        birthday: @student.birthday,
        first_name: @student.first_name,
        gender: @student.gender,
        last_name: @student.last_name,
        preferred_name: @student.preferred_name,
        region_id: @student.region_id,
        year_group: @student.year_group,
        keyboard: @student.keyboard,
      }
    }

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', "No changes made to student."
  end

  test "should fail to update student when missing params" do
    patch student_url(@student), params: {
      student: {
        age: @student.age,
        birthday: @student.birthday,
        first_name: '',
        gender: @student.gender,
        last_name: @student.last_name,
        preferred_name: @student.preferred_name,
        region_id: @student.region_id,
        year_group: @student.year_group,
        keyboard: @student.keyboard,
      }
    }

    assert_response 422

    assert_select 'h1', 'Editing student'

    assert_select 'h2', '1 error prohibited this student from being saved:'
    assert_select 'li', "First name can't be blank"

    assert_select 'form div.field_with_errors label', 'First name'
    assert_select 'form div.field_with_errors input', ''
  end

  test "should fail to destroy student with associations" do
    assert_difference("Student.count", 0) do
      delete student_url(@student)
    end

    assert_redirected_to student_url(@student)
    follow_redirect!

    assert_select 'p', "Rejected destruction of student 'Joel' because it: - has associated student_contacts."
  end

  test "should destroy student" do
    assert_difference("Student.count", 1) do
      post students_url, params: default_student_params
    end

    assert_difference("Student.count", -1) do
      delete student_url(Student.last)
    end

    assert_redirected_to students_url
    follow_redirect!

    assert_select 'p', 'Student was successfully destroyed.'
  end
end
