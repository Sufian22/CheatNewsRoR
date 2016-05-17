class Api::RepliesController < ApplicationController

  #before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  respond_to :json

  def index
    #respond_with Reply.all
    @replies = Reply.all
  end

  def show
    #respond_with Reply.find(params[:id])
    @reply = Reply.find(params[:id])
  end

  def upvote
    #if current_user
    @reply = Reply.find(params[:id])
    #@submission.liked_by current_user
    if @reply.update(valoracio: @reply.votes_for.size+1)
      render json: @reply, status: 201, location: [:api, @reply]
    else
      render json: { errors: @reply.errors }, status: 422
    end

    #redirect_to root_path
    #else # ve de l'api
    #@submission = Submission.find(params[:id])
    #@user = User.find(params[:user_id])
    #end
  end

  def create
    reply = Reply.new(reply_params)

    if reply.save
      render json: reply, status: 201, location: [:api, reply]
    else
      render json: { errors: reply.errors }, status: 422
    end
  end

  def update
    # Falta controlar que solo pueda modificar los suyos

    reply = Reply.find(params[:id])
    if reply.update(reply_params)
      render json: reply, status: 200, location: [:api, reply]
    else
      render json: { errors: reply.errors }, status: 422
    end
  end

  def destroy
    # Falta controlar que solo pueda modificar los suyos

    reply = Reply.find(params[:id])
    reply.destroy
    head 204
  end

  private

  def reply_params
    params.permit(:texto, :user_id, :comment_id, :valoracio)
  end

end