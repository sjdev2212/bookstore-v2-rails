class AddColumnstToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :genre, :string
    add_column :books, :author, :string
    add_column :books, :description, :string
    add_column :books, :image, :string
    add_column :books, :isbn, :bigint
    add_column :books, :date_of_publication, :date
  end
end
