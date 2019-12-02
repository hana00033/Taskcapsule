json.set! :tasks do
  json.array! @tasks do |task|
    json.extract! task, :id, :deadline, :task, :created_at, :updated_at
  end
end
