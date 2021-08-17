class ChangeIsActiveDefaultOnCustomers < ActiveRecord::Migration[5.2]
  def up
     change_column :customers, :is_active,:boolean, default: true
  end
end
