class Api::CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
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