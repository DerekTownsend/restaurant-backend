class Api::V1::AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(username: user_login_params[:username])
    if user && user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: user.id })
      render json: UserSerializer.new(user, token).to_serialized_json, status: :accepted
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :admin)
  end
end
