class Api::RepliesController < ApplicationController

  before_action :authenticate_with_token!

  respond_to :json

  def index
    respond_with Reply.all
  end

  def show
    respond_with Reply.find(params[:id])
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
    params.permit(:texto, :user_id, :comment_id)
  end

end