json.paginate pagination @messages
json.messages(@messages) do |message|
  json.extract! message, :id, :text
  json.author message.user.email
end
