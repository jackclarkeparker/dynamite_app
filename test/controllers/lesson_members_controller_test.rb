require "test_helper"

class LessonMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:miramar_lesson)
  end

  test "should get _new_lesson_member" do
    get new_lesson_member_url(@lesson)
    assert_response :success
  end
end
