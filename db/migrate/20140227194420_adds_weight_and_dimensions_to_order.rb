class AddsWeightAndDimensionsToOrder < ActiveRecord::Migration
  def change
    add_column :products, :weight, :float
    add_column :products, :height, :float
    add_column :products, :width, :float
  end
end
