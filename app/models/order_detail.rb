class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  
  enum making_status:{
    not_startable:             0, #着手不可
    waiting_for_production:    1, #製作待ち
    production:                2, #製作中
    production_completed:      3, #製作完了
  }
end
