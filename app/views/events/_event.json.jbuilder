json.extract! event, :id, :hostname, :org, :created, :created_at, :updated_at
json.url event_url(event, format: :json)