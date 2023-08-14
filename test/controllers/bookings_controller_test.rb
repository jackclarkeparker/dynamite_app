require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get lessons" do
    get bookings_lessons_url
    assert_response :success
  end

  test "should get new_booking" do
    get bookings_new_booking_url
    assert_response :success
  end

  test "should get new_waiting_list_entry" do
    get bookings_new_waiting_list_entry_url
    assert_response :success
  end
end
