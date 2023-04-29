# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      sign_in user, store: false
      user.generate_authentication_token
      user.save
      render json: {user: user, token: user.authentication_token}
    else
      render json: {error: 'Correo o contraseña invalidos'}, status: :unauthorized
    end
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out resource
    render json: {success: true}
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
