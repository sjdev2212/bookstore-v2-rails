class Api::FavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  def index
    @favorites = Favorite.all
    render json: @favorites
  end

  def create
    @user_id = params[:user_id]
    @favorite = Favorite.create(user_id: @user_id, book_id: params[:book_id])
    if @favorite.save
      render json: { message: 'Book added to favorites' }
    else
      render json: { error: 'Failed to add the book to favorites' }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by_id(params[:id])
    if @favorite
      @favorite.destroy
      render json: { message: 'Book removed from favorites' }
    else
      render json: { error: 'Failed to remove the book from favorites' }, status: :unprocessable_entity
    end
  end

  def favorite_per_user
    @favorites = Favorite.where(user_id: params[:user_id])
    render json: @favorites
  end
end
