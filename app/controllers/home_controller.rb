class HomeController < ApplicationController
  before_action :set_submission, only: [:newcomment]
  before_action :set_comment, only: [:newreply]

  def index
    # Para la página principal, donde saldrán todas las submissions sin ningun criterio
    @submissions = Submission.all.select {|new| new.tipo == 1}.sort { |x,y| y <=> x}
  end

  def news
    # Las submissions más recientes, tanto URL como ASK
    @news = Submission.all.order(created_at: :desc)
  end

  def asks
    # Las submissions Ask más recientes
    @asks = Submission.all.select{|new| new.tipo == 2}.sort { |x,y| y <=> x}
  end 
  
  def threads
    # Para la ventana comentarios, ordenados por fecha creacion
    if current_user
      @comments = Comment.all.select{|comment| comment.user_id == current_user.id}
      @replies = Reply.all.select{|reply| reply.user_id == current_user.id}
    else
      redirect_to '/auth/facebook'
    end
  end

  def newreply
    if current_user
      @reply = Reply.new
      @reply.comment_id = @comment.id
      # Hardcoded, habrá que modificarlo por el usuario que esté en sesion
      @reply.user_id = current_user.id
    else
      redirect_to '/auth/facebook'
    end
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
  end

  def createcomment
    if current_user
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save!
      redirect_to home_newcomment_path(:submission_id => @comment.submission_id)
    else
      redirect_to '/auth/facebook'
    end
  end

  def newsubmission
    # Para la ventana de creación de nueva submission
    if current_user
      @submission = Submission.new
      #@submission.update(valoracio: @submission.votes_for.size)
    else
      redirect_to '/auth/facebook'
    end
  end

  def createsubmission
    @submission = Submission.new(submission_params)
    @submission.user_id = current_user.id

    if @submission.link.empty?
      @submission.tipo = 2
    else @submission.tipo = 1
    end

    @submission.save!
    redirect_to home_newcomment_path(:submission_id => @submission.id)
  end

  def edituser
    @user = current_user
  end
  
  def updateuser
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
      params.require(:submission).permit(:title, :link, :description, :tipo)
  end
  
  def user_params
      params.require(:user).permit(:about)
  end
    
end
