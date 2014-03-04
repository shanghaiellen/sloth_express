class AddsDepth < ActiveRecord::Migration
  def change
    add_column :products, :depth, :float
  end
end
