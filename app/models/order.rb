class Order < ActiveRecord::Base
  has_many   :order_items
  has_many   :products, through: :order_items
  belongs_to :user
  has_one    :purchase

  validate :order_items, presence: true

  def cart_size
   order_items.sum(:quantity)
  end


  def get_estimate(zip)
    estimate = {order:  { packages: [],
                          origin: {zip: 98101},
                          destination: {country: 'US',
                                        zip: zip}
                        }
                }
    self.order_items.each do |item|
      estimate[:order][:packages] << {weight: item.product.weight, 
                                      dimensions: item.product.dimension_string,
                                      units: "imperial"}
    end
    # uri = URI.parse("http://example.com/search")

    # # Shortcut
    # response = Net::HTTP.post_form(uri, {"q" => estimate })

    # # Full control
    # http = Net::HTTP.new(uri.host, uri.port)

    # request = Net::HTTP::Post.new(uri.request_uri)
    # request.set_form_data({"q" => "My query", "per_page" => "50"})

    # response = http.request(request)

    HTTParty.post('http://localhost:3000/get_estimate.json', 
                  body: estimate.to_json, 
                  headers: {'Content-Type' => 'application/json'})

  end

end