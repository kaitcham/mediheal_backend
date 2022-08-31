class Api::V1::AuthController < ApplicationController
  skip_before_action :require_login, only: [:login]

  def login
    user = User.find_by(email: login_params[:email])
    if user&.authenticate(login_params[:password])
      payload = { user_id: user.id }
      token = encode_token(payload)
      render json: { user: UserSerializer.new(user), token: token }, status: :accepted
    else
      render json: { failure: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def auto_login
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
