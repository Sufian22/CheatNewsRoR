json.extract! @submission, :id, :title, :link, :description, :tipo, :valoracio, :user_id, :created_at, :updated_at
json.user api_user_url(@submission.user_id)
