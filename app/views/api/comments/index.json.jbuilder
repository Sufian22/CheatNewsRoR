json.array!(@comments) do |comment|
  json.extract! comment, :id, :texto, :valoracio, :user_id, :submission_id, :created_at
  json.comment api_comment_url(comment)
  json.user api_user_url(comment.user_id)
  json.submission api_submission_url(comment.submission_id)
end
g