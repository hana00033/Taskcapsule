json.set! :task do
  json.extract! @task, :id, :deadline, :task, :created_at, :updated_at
end