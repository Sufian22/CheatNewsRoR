class UsersController < ApplicationController

  before_filter :authenticate_user!
  respond_to :json


  def index
    users = User.all
    render json: {
        data: {
            users: users
        }
    },status: :ok
  end


  def show

  end

  def update

  end


  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    #params.require(:user).permit!
    params.permit(:name,:nickname,:image,:email)
  end


end
