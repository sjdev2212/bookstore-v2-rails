class Api::AuthorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @authors = Author.all
    render json: @authors.to_json(include: [:image])
  end

  def show
    @author = Author.find_by_id(params[:id])
    render json: {
      id: author.id,
      name: author.name,
      biography: author.biography,
      date_of_birth: author.date_of_birth,
      image: url_for(author.image),
      nationality: author.nationality
    }
  end

  def create
    @author = Author.create(author_params)
    if author.valid?
      render json: author.to_json(include: [:image]), status: :created
    else
      render json: { error: 'Failed to create the author', details: author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    author = Author.find(params[:id])
    if author.update(author_params)
      render json: author.to_json(include: [:image]), status: :ok
    else
      render json: { error: 'Failed to update the author', details: author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    author = Author.find_by_id(params[:id])
    author.destroy
    render json: { message: 'Author Deleted' }
  end

  private

  def author_params
    params.require(:author).permit(:name, :date_of_birth, :nationality, :biography, :image)
  end
end
