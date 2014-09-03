json.array!(@courses) do |course|
  json.extract! course, :id, :name, :summary, :school_id, :founding_teacher_id
  json.url course_url(course, format: :json)
end
