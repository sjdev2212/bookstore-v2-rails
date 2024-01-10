class Api::FavoritesController < ApplicationController
  def create
    current_user = User.find_by_id(session[:user_id])
    @favorite = current_user.favorites.new(book_id: params[:book_id])
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
end
