class Api::BooksController < ApplicationController
    def index
      @books = Book.all
      render json: @books
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
  
    def filter_title
      # Apply filtering
      filtered_books = Book.all
  
      if params[:title].present?
        filtered_books = filtered_books.where("title ILIKE ?", "%#{params[:title]}%")
      end
  
      if filtered_books.empty?
        render json: { message: 'No books match the filter criteria' }, status: :not_found
        return
      end
      render json: filtered_books
    end
  
    def filter_author
      filtered_books = Book.all
  
      if params[:author].present?
        filtered_books = filtered_books.where("author_name ILIKE ?", "%#{params[:author]}%")
      end
  
      if filtered_books.empty?
        render json: { message: 'No books match the filter criteria' }, status: :not_found
        return
      end
  
      render json: filtered_books
    end
  
    def filter_price
      filtered_books = Book.all
  
      if params[:min_price].present? && params[:max_price].present?
        filtered_books = filtered_books.where("price >= ? AND price <= ?", params[:min_price], params[:max_price])
      end
  
      if filtered_books.empty?
        render json: { message: 'No books match the filter criteria' }, status: :not_found
        return
      end
  
      render json: filtered_books
    end
  
    private
  
    def book_params
      params.require(:book).permit(:title, :price)
    end
  end
  