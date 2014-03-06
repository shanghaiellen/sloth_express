require 'httparty'
class Order < ActiveRecord::Base
  has_many   :order_items
  has_many   :products, through: :order_items
  belongs_to :user
  has_one    :purchase

  validate :order_items, presence: true

  def cart_size
   order_items.sum(:quantity)
  end

  def estimate_params(zip)
    @estimate_params ||= {order:  {packages: [],
                                origin: { country: 'US',
                                          zip: 98101},
                                destination: {country: 'US',
                                              zip: zip}
                              }
                      }
    self.order_items.each do |item|
      @estimate_params[:order][:packages] << {weight: item.product.weight, 
                                      dimensions: item.product.dimension_string,
                                      units: "imperial"}
    end
  end

  def get_estimate(zip)
    estimate_params(zip)
    response ||= HTTParty.post("http://localhost:3000/shipping_estimate.json", 
      body: @estimate_params,
      headers: headers)
    response.parsed_response
  end

  def get_cheapest(zip)
    estimate_params(zip)
    response ||= HTTParty.post("http://localhost:3000/get_cheapest.json", 
      body: @estimate_params)
    response.parsed_response[0..4]
  end

  def get_fastest(zip)
    estimate_params(zip)
    response ||= HTTParty.post("http://localhost:3000/get_fastest.json", 
      body: @estimate_params)
    response.parsed_response[0..4]
  end

  def headers
    time = Time.now.to_i.to_s
    {
        "REQUEST_TIME" => time,
        "REQUEST_SIGNATURE" => ServiceAuthentication.new(ENV["API_KEY"], @params, @path, @method, time).sign
    }
  end

end