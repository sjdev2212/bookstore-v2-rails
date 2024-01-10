class Book < ApplicationRecord
  has_one_attached :image
  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user

def as_json(options = {})
    super(options.merge({
                          methods: [:image_url],
                        }))
  end

  def image_url
    if image.attached?
      # Use the Cloudinary service URL
      Cloudinary::Utils.cloudinary_url(image.key, secure: true)
    else
      nil
    end
  end 
end

