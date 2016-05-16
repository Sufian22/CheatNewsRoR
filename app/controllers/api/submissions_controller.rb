class Api::SubmissionsController < ApplicationController

  before_action :authenticate_with_token!

  respond_to :json

  def index
    respond_with Submission.all
  end

  def show
    respond_with Submission.find(params[:id])
  end

  def create
    submission = Submission.new(submission_params)

    if submission.save
      render json: submission, status: 201, location: [:api, submission]
    else
      render json: { errors: submission.errors }, status: 422
    end
  end

  def update
    submission = Submission.find(params[:id])

    if submission.update(submission_params)
      render json: submission, status: 200, location: [:api, submission]
    else
      render json: { errors: submission.errors }, status: 422
    end
  end

  def destroy
    submission = Submission.find(params[:id])
    submission.destroy
    head 204
  end

  private

  def submission_params
    params.permit(:title, :link, :description, :tipo, :user_id)
  end

end