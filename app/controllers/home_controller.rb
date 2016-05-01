class HomeController < ApplicationController
  before_action :set_submission, only: [:newcomment]
  before_action :set_comment, only: [:newreply]

  def index
    # Para la página principal, donde saldrán todas las submissions sin ningun criterio
    @submissions = Submission.all
  end

  def news
    # Para la ventana news, las submissions más recientes
    @news = Submission.all.order(created_at: :desc)
  end

  def comments
    # Para la ventana comentarios, ordenados por fecha creacion
    @comments = Comment.all.order(created_at: :desc)
  end

  def newreply
    @reply = Reply.new
    @reply.comment_id = @comment.id
    # Hardcoded, habrá que modificarlo por el usuario que esté en sesion
    @reply.user_id = 2
  end

  def createreply
    @reply = Reply.new(reply_params)
    @reply.save!
    @comment = Comment.find(@reply.comment_id)
    redirect_to home_newcomment_path(:submission_id => @comment.submission_id)
  end

  def newcomment
    # Para la ventana de creación de nuevo comentario
    @comment = Comment.new
    @comment.submission_id = @submission.id
    # Hardcoded, habrá que modificarlo por el usuario que esté en sesion
    @comment.user_id = 1
  end

  def createcomment
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to home_newcomment_path(:submission_id => @comment.submission_id)
  end

  def newsubmission
    # Para la ventana de creación de nueva submission
    @submission = Submission.new
  end
  
  def createsubmission
    @submission = Submission.new(submission_params)
    @submission.save!
    redirect_to '/'
  end
  
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:submission_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:texto, :user_id, :submission_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reply_params
    params.require(:reply).permit(:texto, :user_id, :comment_id)
  end

  def submission_params
      params.require(:submission).permit(:title, :link, :description)
  end
    
end
