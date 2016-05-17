json.array!(@submissions) do |submission|
  json.extract! submission, :id, :link, :description, :tipo, :user_id
  json.submission api_submission_url(submission)
  json.user api_user_url(submission.user_id)
end
