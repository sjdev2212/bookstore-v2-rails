class BookSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :genre, :author, :description, :image, :isbn, :date_of_publication
end
