json.extract! student, :id, :preferred_name, :first_name, :last_name, :birthday, :year_group, :gender, :region_id, :created_at, :updated_at
json.url student_url(student, format: :json)
