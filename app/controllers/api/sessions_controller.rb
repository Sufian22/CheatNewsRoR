class Api::SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    user = @user
    session[:user_id] = @user.id
    user.generate_authentication_token!
    render json: user, status: 201, location: [:api, user]
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_path
    head 204
  end

end