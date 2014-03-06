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
    @estimate_params ||= {"order" =>  {"packages" => [],
                                      "origin" => { "country" => 'US',
                                                    "zip" => "98101"},
                                                    "destination" => {"country" => 'US',
                                                                      "zip"=> zip.to_s}
                                      }
                          }
    self.order_items.each do |item|
      item.quantity.times do
        @estimate_params["order"]["packages"] << {"weight" => item.product.weight.to_s, 
                                                  "dimensions" => item.product.dimension_string,
                                                  "units" => "imperial"}
      end
    end
  end

  def get_estimate(zip)
    estimate_params(zip)
    @method = "POST"
    @path = '/shipping_estimate.json'
    response ||= HTTParty.post("http://localhost:3000/#{@path}", 
      body: @estimate_params,
      headers: headers)
    response.parsed_response
  end

  def get_cheapest(zip)
    estimate_params(zip)
    @method = "POST"
    @path = '/shipping_estimate.json'
    response ||= HTTParty.post("http://localhost:3000/#{@path}", 
      body: @estimate_params,
      headers: headers)
    response.parsed_response[0..4]
  end

  def get_fastest(zip)
    estimate_params(zip)
    @method = "POST"
    @path = "/get_fastest.json"
    response ||= HTTParty.post("http://localhost:3000/#{@path}", 
      body: @estimate_params,
      headers: headers)
    response.parsed_response[0..4]
  end

  def headers
    time = Time.now.to_i.to_s
    # @key = ENV["API_KEY"]
    {
      "REQUEST_TIME" => time,
      "REQUEST_SIGNATURE" => ServiceAuthentication.new('testkey', @estimate_params, @path, @method, time).sign
    }
  end

end