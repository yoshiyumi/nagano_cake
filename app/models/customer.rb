class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  
validates :first_name, presence: true
validates :last_name, presence: true
validates :first_name_kana, presence: true
validates :last_name_kana, presence: true
validates :postal_code, presence: true
validates :telephone_number, presence: true
validates :address, presence: true
validates :email, presence: true


  def full_name
    self.last_name + " " + self.first_name
  end

  def full_address
    "〒" + " " + self.postal_code + " " + self.address
  end
end
