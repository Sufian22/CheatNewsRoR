json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :link, :description, :tipo, :valoracio, :user_id, :created_at
  json.submission api_submission_url(submission)
  json.user api_user_url(submission.user_id)
end
