json.array!(@replies) do |reply|
  json.extract! reply, :id, :texto, :user_id, :comment_id
  json.url reply_url(reply, format: :json)
end
