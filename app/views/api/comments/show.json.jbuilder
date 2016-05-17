json.extract! @comment, :id, :texto, :valoracio, :user_id, :submission_id, :created_at, :updated_at
json.user api_user_url(@comment.user_id)
json.submission api_submission_url(@comment.submission_id)