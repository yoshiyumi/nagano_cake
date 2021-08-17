class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy



  enum payment_method:{
    credit_card:     0, #クレジットカード
    bank_transfer:   1, #銀行振込
  }



  enum status:{
    waiting_for_payment:     0, #入金待ち
    payment_confirmation:    1, #入金確認
    production:              2, #製作中
    reade_to_ship:           3, #発送準備中
    sent:                    4, #発送済み
  }

  def full_address
    "〒" + " " + self.postal_code + " " + self.address
  end
end

