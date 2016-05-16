class Api::CommentsController < ApplicationController


  # GET /comments
  # GET /comments.json
  def index
    respond_with Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_with Comment.find(params[:id])
  end

  def update

      if @comment.update(comment_params)
        render json: comment, status: 201, location: [:api, comment]
      else
        render json: { errors: @comment.errors }, status: 422
      end
  end

  def destroy
    @comment.destroy
    head 204
  end


end