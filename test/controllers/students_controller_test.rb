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

  test "should create student without preferred name" do
    params = default_student_params
    params[:student][:preferred_name] = ''

    assert_difference("Student.count", 1) do
      post students_url, params: params
    end

    assert_redirected_to student_url(Student.last)
    follow_redirect!

    assert_select 'p', 'Student was successfully created.'
  end

  test "should fail to create student with missing params" do
    assert_difference("Student.count", 0) do
      post students_url, params: {
        student: {
          first_name: '',
          last_name: '',
          preferred_name: '',
          birthday: nil,
          year_group: '',
          region_id: '',
          keyboard: 'Unknown',
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New student'
    assert_select 'h2', '5 errors prohibited this student from being saved:'
    assert_select 'li', "First name can't be blank"
    assert_select 'li', "Last name can't be blank"
    assert_select 'li', "Age can't be blank"
    assert_select 'li', "Gender can't be blank"
    assert_select 'li', 'Region must be selected'
  end

  test "Should fail to create student with invalid region selection" do
    params = default_student_params
    params[:student][:region_id] = 123456789

    post students_url, params: params

    assert_response 422

    assert_select 'h1', 'New student'
    assert_select 'h2', '1 error prohibited this student from being saved:'
    assert_select 'li', 'Region must be selected'
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
        first_name: @student.first_name,
        gender: '',
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
    assert_select 'li', "Gender can't be blank"

    assert_select 'form div' do
      assert_select 'label', 'First name'
      assert_select 'input', ''
    end
  end

  test "should destroy student" do
    assert_difference("Student.count", -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
