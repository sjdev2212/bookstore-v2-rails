class Author < ApplicationRecord
  has_many :books
  has_one_attached :image
  belongs_to :publisher

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
