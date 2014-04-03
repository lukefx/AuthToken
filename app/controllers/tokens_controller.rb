class TokensController < ApplicationController

  # GET tokens, http header 'Authorizazion' TOKEN
  # GET tokens/iHi56sesgI5wiGoF1s-zZA
  # GET tokens?token=iHi56sesgI5wiGoF1s-zZA
  def index
    @user = User.find_by_token(@token || params[:token])
    if @user && @user.expiration > 2.hours.ago
      render json: { token: @user.token, data: JWT.encode(@user, Rails.application.secrets.secret_key_base) }
    else
      @user.delete # delete expired token
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
      user.request_ip = params[:remote_ip] || request.remote_ip
    end
    render json: { token: @user.token, data: JWT.encode(@user, Rails.application.secrets.secret_key_base) }
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
