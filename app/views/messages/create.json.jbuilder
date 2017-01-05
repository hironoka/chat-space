if @message.errors.full_messages.blank?
  json.body  @message.body
  json.image @message.image.url
  json.time  @message.time
  json.name  @message.user.name
else
  json.error @message.errors.full_messages.first
end
