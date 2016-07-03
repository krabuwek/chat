json.array!(@users) do |user|
  json.extract! user, :id, :email, :id
  json.url user_url(user, format: :json)
end
