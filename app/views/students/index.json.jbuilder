json.array!(@students) do |student|
  json.extract! student, :id, :name, :about, :level
  json.url student_url(student, format: :json)
end
