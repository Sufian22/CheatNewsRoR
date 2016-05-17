class Api::RepliesController < ApplicationController

  before_action :authenticate_with_token!, only: [:create,:upvote]

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
    @reply = Reply.find(params[:id])
    if @reply.user_id != @current_user.id
      @reply.liked_by @current_user
      if @reply.update(valoracio: @reply.votes_for.size)
        render json: @reply, status: 201, location: [:api, @reply]
      else
        render json: { errors: @reply.errors }, status: 422
      end
    else
      render json: { errors: "You are not allowed to vote your replies" }, status: 405
    end
  end

  def create
    reply = Reply.new(reply_params)
    reply.user_id = @current_user.id
    reply.valoracio = 0

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