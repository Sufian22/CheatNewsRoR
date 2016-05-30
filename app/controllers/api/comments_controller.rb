class Api::CommentsController < ApplicationController

  before_action :authenticate_with_token!, only: [:create,:upvote]

  respond_to :json

  def index
    #respond_with Comment.all
    @comments = Comment.all.reversed
  end

  def show
    #respond_with Comment.find(params[:id])
    @comment = Comment.find(params[:id])
  end

  def upvote
    @comment = Comment.find(params[:id])
    if @comment.user_id != @current_user.id
      @comment.liked_by @current_user
      if @comment.update(valoracio: @comment.votes_for.size)
        render json: @comment, status: 201, location: [:api, @comment]
      else
        render json: { errors: @comment.errors }, status: 422
      end
    else
      render json: { errors: "You are not allowed to vote your comments" }, status: 405
    end
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = @current_user.id
    comment.valoracio = 0

    if comment.save
      render json: comment, status: 201, location: [:api, comment]
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  def update
    # Falta controlar que solo pueda modificar los suyos
    comment = Comment.find(params[:id])

    if comment.update(comment_params)
      render json: comment, status: 200, location: [:api, comment]
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  def destroy
    # Falta controlar que solo pueda modificar los suyos

    comment = Comment.find(params[:id])
    comment.destroy
    head 204
  end

  private

  def comment_params
    params.permit(:texto, :user_id, :submission_id, :valoracio)
  end

end