class Api::SubmissionsController < ApplicationController

  helper_method :getAuthor

  def index
    respond_with Submission.all
  end

  def show
    respond_with Submission.find(params[:id])
  end

  def update
    if @submission.update(submission_params)
      render json: submission,  status: 201, location: [api: submission]
    else
      render json: { errors: @submission.errors }, status: 422
    end
  end

  def destroy
    @submission.destroy
    head 204
  end

end