class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: 'Logged out successfully' }
  end

  private

  def generate_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end
end
