class Api::SubmissionsController < ApplicationController

  #before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  respond_to :json

  def index
    #respond_with Submission.all
    @submissions = Submission.all
  end

  def show
    #respond_with Submission.find(params[:id])
    @submission = Submission.find(params[:id])
  end

  def create
    submission = Submission.new(submission_params)

    if submission.save
      render json: submission, status: 201, location: [:api, submission]
    else
      render json: { errors: submission.errors }, status: 422
    end
  end

  def upvote
    #if current_user
      @submission = Submission.find(params[:id])
      #@submission.liked_by current_user
      if @submission.update(valoracio: @submission.votes_for.size+1)
        render json: @submission, status: 201, location: [:api, @submission]
      else
        render json: { errors: @submission.errors }, status: 422
      end
      #redirect_to root_path
    #else # ve de l'api
      #@submission = Submission.find(params[:id])
      #@user = User.find(params[:user_id])
    #end
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