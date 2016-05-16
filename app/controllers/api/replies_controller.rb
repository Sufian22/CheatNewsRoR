class Api::RepliesController < ApplicationController


  # GET /replies
  # GET /replies.json
  def index
    respond_with Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    respond_with Reply.find(params[:id])
  end

  def update
      if @reply.update(reply_params)
        render json: replies, status: 201, location: [:api, replies]
      else
        render json: { errors: @reply.errors }, status: 422
       end
  end

  def destroy
    @reply.destroy
    head 204
  end

end