class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end
  
   # GET /submissions/newest
  def newest
    @submissions = Submission.all.reversed
  end
  

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    if current_user
      @submission = Submission.find(params[:id])
      @submission.liked_by current_user
      @submission.update(valoracio: @submission.votes_for.size)
      redirect_to root_path
    else # ve de l'api
      @submission = Submission.find(params[:id])
      @user = User.find(params[:user_id])
    end
  end

  def formatted_url(submissionurl)
      url_format=submissionurl.split(".").second
      aux=submissionurl.split(".")[2]
      url_format.try(:concat,".") 
      aux = aux.try(:split, "/").try(:first)
      url_format.try(:concat,aux) 
      return url_format
  end
  helper_method :formatted_url
  
  
  
  private

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:title, :link, :description, :tipo, :user_id)
    end
end
