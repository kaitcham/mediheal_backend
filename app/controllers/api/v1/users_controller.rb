class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create]

  def index
    users = User.all
    render json: users, status: :ok
  end

  def create
    user = User.create(user_params)
    if user.valid?
      payload = { user_id: user.id }
      token = encode_token(payload)
      render json: { user: UserSerializer.new(user), token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
