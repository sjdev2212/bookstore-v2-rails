class User < ApplicationRecord
  has_secure_password
  has_many :favorites
  has_many :favorite_books, through: :favorites, source: :book

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, presence: { default: 'user' }
end
