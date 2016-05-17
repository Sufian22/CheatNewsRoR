json.extract! @reply, :id, :texto, :valoracio, :user_id, :comment_id, :created_at, :updated_at
json.user api_user_url(@reply.user_id)
json.comment api_comment_url(@reply.comment_id)
