json.array!(@conferences) do |conference|
  json.extract! conference, :id, :id
  json.url conference_url(conference, format: :json)
end
