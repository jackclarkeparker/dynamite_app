json.extract! lesson, :id, :tutor_id, :venue_id, :day, :start_time, :capacity, :standard_price, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
