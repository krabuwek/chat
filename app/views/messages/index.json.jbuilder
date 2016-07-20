json.paginate pagination @messages
json.messages(@messages) do |message|
  json.extract! message, :id, :text
  json.author message.user.email
  json.author_id message.user.id
end
