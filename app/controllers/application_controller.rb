class ApplicationController < ActionController::API

  before_action :authorization_token, except: [ :create ]

  private

  def authorization_token
    if request.headers['Authorization']
      @token = request.headers['Authorization'].split(' ').last
    end
  end

end
