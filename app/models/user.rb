class User < ActiveRecord::Base

  before_create :generate_token

  def public_data
    { username: self.username, expiration: self.expiration }
  end

  def generate_token
    self.token = loop do
      # random_token = SecureRandom.urlsafe_base64(nil, false)
      random_token = SecureRandom.uuid.gsub('-','').upcase
      break random_token unless User.exists?(token: random_token)
    end
  end

end
