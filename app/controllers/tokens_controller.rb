class TokensController < ApplicationController

  def index
    @user = User.find_by_token(@token || params[:token])
    if @user && @user.expiration > 2.hours.ago
      render json: { token: @user.token, data: JWT.encode(@user.public_data, Rails.application.secrets.secret_key_base) }
    else
      @user.delete if @user
      render nothing: true, status: :unauthorized
    end
  end

  def new
    render json: { strategies: OmniAuth::Strategies.constants }
  end

  def create
    auth = auth_hash
    @user = User.find_or_create_by username: auth_hash['info']['nickname'] do |user|
      user.expiration = Time.zone.now
      user.request_ip = params[:remote_ip] || find_remote_ip
    end
    reset_session # we go completely stateless
    render json: { token: @user.token, data: JWT.encode(@user.public_data, Rails.application.secrets.secret_key_base) }
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def find_remote_ip
    request.headers["X-Forwarded-For"] || request.remote_ip
  end

end
