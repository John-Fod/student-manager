json.array!(@schools) do |school|
  json.extract! school, :id, :headmaster_id, :name, :summary, :student_count
  json.url school_url(school, format: :json)
end
