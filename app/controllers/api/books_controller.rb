class Api::BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @books = Book.all
    render json: @books.to_json(include: [:image])
  end

  def show
    @book = Book.find_by_id(params[:id])
    render json: {
      id: @book.id,
      title: @book.title,
      price: @book.price,
      author: @book.author,
      description: @book.description,
      isbn: @book.isbn,
      genre: @book.genre,
      image: url_for(@book.image),
      date: @book.date_of_publication 
      # Add other attributes as needed
    }
  end
  def create
    @book = Book.create(book_params)
    
    if @book.valid?
      render json: @book.to_json(include: [:image]), status: :created
    else
      render json: { error: 'Failed to create the book', details: @book.errors.full_messages }, status: :unprocessable_entity
    end
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
