class Author < ApplicationRecord
  has_many :books
  has_one_attached :author_image


  def as_json(options = {})
    super(options.merge({
                          methods: [:image_url],
                        }))
  end

  def image_url
    if author_image.attached?
      # Use the Cloudinary service URL
      Cloudinary::Utils.cloudinary_url(author_image.key, secure: true)
    else
      nil
    end
  end
end
