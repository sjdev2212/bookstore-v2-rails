class AddColumnsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :title, :string
    add_column :books, :price, :float
  end
end
