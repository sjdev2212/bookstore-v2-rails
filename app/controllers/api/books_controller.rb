class Api::BooksController < ApplicationController
  def index
    @books = Book.all
    render json: @books.to_json(include: [:image])
  end

  def show
    @book = Book.find_by_id(params[:id])
    render json: @book
  end

  def create
    @book = Book.create(book_params)
    render json: @book
  end

  def update
    @book = Book.find_by_id(params[:id])
    @book.update(book_params)
    render json: @book
  end

  def destroy
    @book = Book.find_by_id(params[:id])
    @book.destroy
    render json: { message: 'Book Deleted' }
  end

  private

  def book_params
    params.require(:book).permit(:title, :price, :genre, :author, :description, :image, :isbn, :date_of_publication)
  end
end
