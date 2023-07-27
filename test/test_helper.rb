ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  QUOTE_UNICODE = '&#39;'

  def default_tutor_params
    {
      tutor: {
        first_name: 'Gary',
        last_name: 'Mason',
        preferred_name: 'Gee',
        email_address: 'gary@email.com',
        phone_number: '022 676 7676',
        region_id: regions(:wellington).id,
        delivery_address: '39 Majoribanks St',
      }
    }
  end

  def default_lesson_params
    {
      lesson: {
        tutor_id: tutors(:andy).id,
        venue_id: venues(:miramar).id,
        week_day_index: Date::DAYNAMES.index('Monday'),
        start_time: '09:00:00',
        duration: 30,
        capacity: 4,
        availability: 4,
        standard_price: 16,
      }
    }
  end

  def default_student_params
    {
      student: {
        first_name: 'Arya',
        last_name: 'Babblehauer',
        full_name: 'Arya Babblehauer',
        preferred_name: '',
        birthday: '2014-03-13',
        year_group: 5,
        gender: 'female',
        region_id: regions(:wellington).id,
        keyboard: 'Unknown',
      }
    }
  end
end
