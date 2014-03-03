class AddsShippingToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :shipping, :string
  end
end
