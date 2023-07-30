require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:miramar_lesson)
  end

  test "should get index" do
    get lessons_url
    assert_response :success
  end

  test "should get new" do
    get new_lesson_url
    assert_response :success
  end

  test "should create lesson" do
    assert_difference("Lesson.count", 1) do
      post lessons_url, params: default_lesson_params
    end

    assert_redirected_to lesson_url(Lesson.last)
    follow_redirect!

    assert_select 'p', "Lesson was successfully created."
    assert_select 'main div p', /Tutor:.{5}Andy/m
    assert_select 'main div p', /End time:.{5}9:30am/m
  end

  test "should fail to create lesson with missing params" do
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: {
        lesson: {
          tutor_id: '',
          venue_id: '',
          week_day_index: '',
          start_time: '',
          duration: '',
          capacity: '',
          standard_price: '',
        }
      }
    end

    assert_select 'h1', 'New lesson'
    assert_select 'h2', '7 errors prohibited this lesson from being saved:'
    assert_select 'li', "Standard price can't be blank"
    assert_select 'li', "Capacity can't be blank"
    assert_select 'li', "Duration can't be blank"
    assert_select 'li', "Start time can't be blank"
    assert_select 'li', 'Venue must be selected'
    assert_select 'li', 'Tutor must be selected'
    assert_select 'li', 'Day must be selected'
  end

  test "should fail to create lesson with standard_price outside bounds" do
    params = default_lesson_params
    params[:lesson][:standard_price] = 0.99
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    params[:lesson][:standard_price] = 50.01
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    assert_select 'h1', 'New lesson'
    assert_select 'h2', '1 error prohibited this lesson from being saved:'
    assert_select 'li', 'Standard price must be no less than 1, and no greater than 50'
  end

  test "should fail to create lesson with capacity outside bounds" do
    params = default_lesson_params
    params[:lesson][:capacity] = 0
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    params[:lesson][:capacity] = 7
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    assert_select 'h1', 'New lesson'
    assert_select 'h2', '1 error prohibited this lesson from being saved:'
    assert_select 'li', 'Capacity must be no less than 1, and no greater than 6'
  end

  test "should fail to create lesson when venue already in use" do
    params = default_lesson_params
    params[:lesson][:tutor_id] = tutors(:natalie).id
    params[:lesson][:start_time] = '15:00:00'

    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    assert_select 'h1', 'New lesson'
    assert_select 'h2', '1 error prohibited this lesson from being saved:'
    assert_select 'li', 'Venue is already being used during this timeslot'

    params[:lesson][:start_time] = '14:31:00'
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end
    assert_select 'li', 'Venue is already being used during this timeslot'

    params[:lesson][:start_time] = '15:29:00'
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end
    assert_select 'li', 'Venue is already being used during this timeslot'

    params[:lesson][:start_time] = '14:30:00'
    assert_difference("Lesson.count", 1) do
      post lessons_url, params: params
    end
    follow_redirect!
    assert_select 'p', "Lesson was successfully created."

    params[:lesson][:start_time] = '15:30:00'
    assert_difference("Lesson.count", 1) do
      post lessons_url, params: params
    end
    follow_redirect!
    assert_select 'p', "Lesson was successfully created."
  end

  test "should fail to create lesson when tutor is already teaching" do
    params = default_lesson_params
    params[:lesson][:venue_id] = venues(:newtown).id
    params[:lesson][:start_time] = '15:00:00'

    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end

    assert_select 'h1', 'New lesson'
    assert_select 'h2', '1 error prohibited this lesson from being saved:'
    assert_select 'li', 'Tutor is already teaching during this timeslot'

    params[:lesson][:start_time] = '14:31:00'
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end
    assert_select 'li', 'Tutor is already teaching during this timeslot'

    params[:lesson][:start_time] = '15:29:00'
    assert_difference("Lesson.count", 0) do
      post lessons_url, params: params
    end
    assert_select 'li', 'Tutor is already teaching during this timeslot'

    params[:lesson][:start_time] = '14:30:00'
    assert_difference("Lesson.count", 1) do
      post lessons_url, params: params
    end
    follow_redirect!
    assert_select 'p', "Lesson was successfully created."

    params[:lesson][:start_time] = '15:30:00'
    assert_difference("Lesson.count", 1) do
      post lessons_url, params: params
    end
    follow_redirect!
    assert_select 'p', "Lesson was successfully created."
  end

  test "should show lesson" do
    get lesson_url(@lesson)
    assert_response :success
  end

  test "should get edit" do
    get edit_lesson_url(@lesson)
    assert_response :success
  end

  # test "should update lesson" do
  #   patch lesson_url(@lesson), params: { lesson: { capacity: @lesson.capacity, day: @lesson.day, standard_price: @lesson.standard_price, start_time: @lesson.start_time, tutor_id: @lesson.tutor_id, venue_id: @lesson.venue_id } }
  #   assert_redirected_to lesson_url(@lesson)
  # end

  test "should alert of update without changes" do
    patch lesson_url(@lesson), params: {
      lesson: {
        tutor_id: @lesson.tutor_id,
        venue_id: @lesson.venue_id,
        week_day_index: @lesson.week_day_index,
        start_time: @lesson.start_time,
        duration: @lesson.duration,
        capacity: @lesson.capacity,
        standard_price: @lesson.standard_price,
      }
    }

    assert_redirected_to lesson_url(@lesson)
    follow_redirect!

    assert_select 'p', "No changes made to lesson."
  end

  test "should fail to update lesson with missing param" do
    patch lesson_url(@lesson), params: {
      lesson: {
        duration: ''
      }
    }

    assert_select 'h1', 'Editing lesson'

    assert_select 'h2', '1 error prohibited this lesson from being saved:'
    assert_select 'li', "Duration can't be blank"

    assert_select 'form div' do
      assert_select 'label', 'Duration'
      assert_select 'input', ''
    end
  end

  # test "should destroy lesson" do
  #   assert_difference("Lesson.count", -1) do
  #     delete lesson_url(@lesson)
  #   end

  #   assert_redirected_to lessons_url
  # end
end
