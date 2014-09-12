class ApplicationController < ActionController::API

  before_action :authorization_token, except: [ :create ]

  private

  def authorization_token

    if request.headers['Authorization']
      @token = request.headers['Authorization'].split(' ').last
    end

    # I'm not so happy about this if...
    if request.headers['token'] || request.headers['Token']
      @token = request.headers['token'] || request.headers['Token']
    end

  end

end
