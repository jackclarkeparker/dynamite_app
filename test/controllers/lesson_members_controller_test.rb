require "test_helper"

class LessonMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get _new_lesson_member" do
    get lesson_members__new_lesson_member_url
    assert_response :success
  end
end
