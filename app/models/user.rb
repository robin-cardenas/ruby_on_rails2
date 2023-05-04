class User < ApplicationRecord
  belongs_to :company
  
  devise :database_authenticatable, :registerable, :token_authenticatable,
          :recoverable, :rememberable, :validatable, :trackable

  validates :email, :password, :company_id, presence: true

  def generate_authentication_token
    loop do
      self.authentication_token = Devise.friendly_token
      break unless User.find_by(authentication_token: authentication_token)
    end
  end
end
