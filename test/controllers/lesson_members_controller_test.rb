require "test_helper"

class LessonMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:miramar_lesson)
  end

  test "should display lesson_members" do
    get lesson_url(@lesson)

    assert_response 200

    assert_select 'div.lesson-members' do
      assert_select 'h2', 'Lesson Members'
      assert_select 'table a', 'Joel'
    end
  end

  test "should get new_lesson_member" do
    get new_lesson_member_url(@lesson)
    assert_response :success

    assert_select 'h1', 'New lesson member'
    assert_select 'input[type="submit"][value="Add student to lesson"]'
  end

  test "should create new_lesson_member" do
    assert_difference('LessonMember.count', 1) do
      post lesson_members_url(@lesson), params: {
        lesson_member: {
          lesson_id: @lesson.id,
          student_id: students(:alice).id,
        }
      }
    end

    assert_redirected_to lesson_url(@lesson)
    follow_redirect!

    assert_select 'p', 'Student added to lesson.'

    assert_select 'div.lesson-members' do
      assert_select 'table a', 'Alice'
    end
  end

  test "should fail to create lesson_member with missing params" do
    assert_difference('LessonMember.count', 0) do
      post lesson_members_url(@lesson), params: {
        lesson_member: {
          lesson_id: '',
          student_id: '',
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New lesson member'
    assert_select 'h2', '2 errors prohibited this lesson member from being saved:'
    assert_select 'li', 'Student must be selected'
    assert_select 'li', 'Lesson must be selected'
  end

  test "should fail to create lesson_member with existing student/lesson combo" do
    joel_miramar = lesson_members(:joel_miramar)
    assert_difference('LessonMember.count', 0) do
      post lesson_members_url(@lesson), params: {
        lesson_member: {
          lesson_id: joel_miramar.lesson_id,
          student_id: joel_miramar.student_id,
        }
      }
    end

    assert_response 422

    assert_select 'h1', 'New lesson member'
    assert_select 'h2', '2 errors prohibited this lesson member from being saved:'
    assert_select 'li', 'Student must be selected'
    assert_select 'li', 'Lesson must be selected'
  end

  test "should delete lesson_member" do
    joel_miramar = lesson_members(:joel_miramar)
    assert_difference('LessonMember.count', -1) do
      delete lesson_member_url({
        lesson_id: joel_miramar.lesson_id,
        student_id: joel_miramar.student_id,
      })
    end

    assert_redirected_to lesson_path(joel_miramar.lesson_id)
    follow_redirect!

    assert_select 'p', 'Student removed from lesson.'
    
    first_tds = css_select 'div.lesson-members table tr td:first-of-type'
    assert first_tds.none? { |td| css_select(td, 'a').text == 'Joel' }
  end
end
