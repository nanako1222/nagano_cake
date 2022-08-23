class Item < ApplicationRecord
  has_one_attached :image

  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
