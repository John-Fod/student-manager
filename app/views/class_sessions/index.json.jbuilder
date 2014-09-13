json.array!(@class_sessions) do |class_session|
  json.extract! class_session, :id, :room_id, :teacher_id, :school_id, :name, :summary, :held_at
  json.url class_session_url(class_session, format: :json)
end
