class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  before_create :create_name
  def create_name
    self.name = "#{first_name} #{last_name}"
  end

  before_create :create_name_kana
  def create_name_kana
    self.name_kana = "#{first_name_kana} #{last_name_kana}"
  end
end
