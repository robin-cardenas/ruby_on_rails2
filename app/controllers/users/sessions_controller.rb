# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # include Responders::ControllerMethod
  
  respond_to :json

  def new
    super
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      sign_in user, strore: false

      user.generate_authentication_token
      user.save

      render json: {token: user.authentication_token}
    else
      render json: {error: 'Correo o contraseña invalidos'}, status: :unauthorized
    end
  end

  def destroy
    super
  end

end
