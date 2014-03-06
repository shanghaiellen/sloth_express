require 'net/http'
class Purchase < ActiveRecord::Base
  belongs_to :order

  validates :email, presence: true, format: {with: /\w+@\w+\.\w+/i}
  validates :address, presence: true
  validates :name, presence: true
  validates :cc_number, presence: true, numericality: true, length: { is: 16 }
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :cvv, presence: true, numericality: true, length: { is: 3 }
  validates :zipcode, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :shipping

def initialize(user_id)
  @user_id = user_id
end


  #def get_sloth_ship
  #  uri = URI('http://localhost:3000/shipping')
  #  hash = { :name => "foo", :bar => "sue" }
  #  res = Net::HTTP.post_form(uri, { :data => JSON.dump(hash) })
  #  render text: res.body
  #end

end
