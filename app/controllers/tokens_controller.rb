class TokensController < ApplicationController

  # GET tokens
  # GET tokens/iHi56sesgI5wiGoF1s-zZA
  # GET tokens?token=iHi56sesgI5wiGoF1s-zZA
  def index
    @user = User.find_by_token(@token || params[:token])
    if @user && @user.expiration > 2.hours.ago
      render json: { token: @user.token, data: JWT.encode(@user, Rails.application.secrets.secret_key_base) }
    else
      render nothing: true, status: :unauthorized
    end
  end

  def create
    auth = LoginService.new(params[:username])
    if auth.authenticate(params[:password])
      @user = User.create username: params[:username], expiration: Time.zone.now, request_ip: request.remote_ip
      render json: { token: @user.token, data: JWT.encode(@user, Rails.application.secrets.secret_key_base) }
    else
      render nothing: true, status: :unauthorized
    end
  end

end
