class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
          :recoverable, :rememberable, :validatable, :trackable

  def generate_authentication_token
    loop do
      self.authentication_token = Devise.friendly_token
      break unless User.find_by(authentication_token: authentication_token)
    end
  end
end
