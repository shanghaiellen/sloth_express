class Product < ActiveRecord::Base
  validates :stock, presence: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {:greater_than => 0}
  validates :user_id, presence: true
  validates :weight, presence: true, numericality: {greater_than: 0}
  validates :height, presence: true, numericality: {greater_than: 0}
  validates :width, presence: true, numericality: {greater_than: 0}
  validates :depth, presence: true, numericality: {greater_than: 0}

  has_many   :product_categories
  has_many   :categories, through: :product_categories
  has_many   :order_items
  has_many   :orders, through: :order_items
  has_many   :reviews
  belongs_to :user

  def self.search(query)
    Product.where(["name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%"])
  end

  # the params here are actually product_params. params is just shorter to write
  def imperialize(params)
    self.weight = (params[:weight].to_f * 0.00220462).round(2)
    self.height = (params[:height].to_f / 2.54).round(2)
    self.depth = (params[:depth].to_f / 2.54).round(2)
    self.width = (params[:width].to_f / 2.54).round(2)
  end

  
  def dimension_string
    [self.height, self.width, self.depth].join(",")
  end
end
