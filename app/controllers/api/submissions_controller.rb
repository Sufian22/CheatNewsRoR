class Api::SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  helper_method :getAuthor

  def index
    if params[:submission_type] == "show"
      @submissions = Submission.where.not(url: '').order(created_at: :desc)
    elsif params[:submission_type] == "ask"
      @submissions = Submission.where.not(content: '').order(created_at: :desc)
    elsif params[:submission_type] == nil || params[:submission_type] == ''
      @submissions = Submission.all.order(created_at: :desc)
    else
      render :json => {:status => "400", :error => "Bad Request"}, status: :bad_request
    end
  end

  def show
  end

end