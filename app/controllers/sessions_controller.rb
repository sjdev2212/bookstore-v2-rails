class SessionsController < ApplicationController
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
      # Implement logout logic if needed
      # For JWT, you often handle logout on the client-side (e.g., by removing the token)
      render json: { message: 'Logged out successfully' }
    end
  
    private
  
    def generate_token(user)
      payload = { user_id: user.id }
      JWT.encode(payload, ENV['JWT_SECRET_KEY'])
    end
  end
  