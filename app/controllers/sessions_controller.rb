class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.find_by(email: params[:email])

    if !user
      render json: { error: 'User does not exist' }, status: :not_found
    elsif !user.authenticate(params[:password])
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    else
      token = generate_token(user)
      render json: { user: user, token: token }
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
