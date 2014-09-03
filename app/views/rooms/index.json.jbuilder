json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :summary, :school_id, :founding_teacher_id
  json.url room_url(room, format: :json)
end
