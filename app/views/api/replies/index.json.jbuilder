json.array!(@replies) do |reply|
  json.extract! reply, :id, :texto, :valoracio, :user_id, :comment_id, :created_at
  json.reply api_reply_url(reply)
  json.user api_user_url(reply.user_id)
  json.comment api_comment_url(reply.comment_id)
end
