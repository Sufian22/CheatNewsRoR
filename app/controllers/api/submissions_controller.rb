class Api::SubmissionsController < ApplicationController

  before_action :authenticate_with_token!, only: [:create,:upvote]

  respond_to :json

  def index
    #respond_with Submission.all
    @submissions = Submission.all.order(id: :desc)
  end

  def show
    #respond_with Submission.find(params[:id])
    @submission = Submission.find(params[:id])
  end

  def create
    submission = Submission.new(submission_params)
    submission.user_id = @current_user.id
    submission.valoracio = 0

    if submission.link.nil?
      submission.tipo = 2
    else
      submission.tipo = 1
    end

    if submission.save
      render json: submission, status: 201, location: [:api, submission]
    else
      render json: { errors: submission.errors }, status: 422
    end
  end

  def upvote
    @submission = Submission.find(params[:id])
    if @submission.user_id != @current_user.id
      @submission.liked_by @current_user
      if @submission.update(valoracio: @submission.votes_for.size)
        render json: @submission, status: 201, location: [:api, @submission]
      else
        render json: { errors: @submission.errors }, status: 422
      end
    else
      render json: { errors: "You are not allowed to vote your submissions" }, status: 405
    end
  end

  def update
    # Falta controlar que solo pueda modificar los suyos

    submission = Submission.find(params[:id])
    if submission.update(submission_params)
      render json: submission, status: 200, location: [:api, submission]
    else
      render json: { errors: submission.errors }, status: 422
    end
  end

  def destroy
    # Falta controlar que solo pueda borrar los suyos

    submission = Submission.find(params[:id])
    submission.destroy
    head 204
  end

  private

  def submission_params
    params.permit(:title, :link, :description, :tipo, :user_id, :valoracio)
  end

end