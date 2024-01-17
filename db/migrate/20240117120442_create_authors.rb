class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.text :biography, null: false
      t.date :date_of_birth, null: false
      t.string :nationality, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
