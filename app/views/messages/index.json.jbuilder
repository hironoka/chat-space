json.array! @messages do |message|
  json.body  message.body
  json.image message.image.url
  json.time  message.time
  json.name  message.user.name
end
