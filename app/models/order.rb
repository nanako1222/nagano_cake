class Order < ApplicationRecord
  has_one_attached :image

  enum payment: { credit_card: 0, transfer: 1 }
  enum address_method: { own_address: 0, new_address: 1 }

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
