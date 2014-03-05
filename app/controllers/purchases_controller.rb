require 'net/http'

class PurchasesController < ApplicationController

  def new
    @purchase = Purchase.new
    @order = Order.find(session[:order_id])
  end

  def show
    @purchase = Purchase.find(params[:id])
    @total = 0
  end

  def billing
    if valid_zip(params[:zipcode])
      @order = Order.find(session[:order_id])
      @estimate = @order.get_estimate(params[:zipcode])
      @cheapest = @order.get_cheapest(params[:zipcode])
      @fastest = @order.get_fastest(params[:zipcode])
      @purchase = Purchase.new
    else
      redirect_to '/purchases/new', notice: 'You must provide a valid zipcode'
    end
  end

  def create
    @purchase = Purchase.new(purchase_params)
    # this is a little ridiculous, and I'm not sure why it's necessary,
    # but it's helping deal with the legacy code
    @purchase.order = current_order
    @order_items = OrderItem.where(order_id: session[:order_id])

    if @purchase.save
      @order_items.each do |order_item|
        order_item.product.stock -= order_item.quantity
        if order_item.product.stock == 0
          order_item.product.update(item_status: "retired")
        end
        order_item.product.save
      end
      current_order.status = "paid"
      current_order.save
      session[:order_id] = nil

      redirect_to purchase_path(@purchase.id), notice: 'Thank you for your order!'
    else
      redirect_to new_path, notice: 'Your order was not completed. Please try again!'
    end
  end

  def get_sloth_ship
    uri = URI('http://localhost:3000/hello')
    hash = { :name => "foo", :bar => "sue" }
    res = Net::HTTP.post_form(uri, { :data => JSON.dump(hash) })
    render text: res.body
  end

  private
  def purchase_params
    params.require(:purchase).permit(:email, :address, :name, :cc_number, :cvv, :zipcode, :expiration_month, :expiration_year, :order_id, :product_id, :shipping)
  end

  def valid_zip(zip)
    # I'm pretty sure that the parentheses are unnecessary, but they help
    # with readability
    !zip.nil? && (zip.to_i != 0) && (zip.length == 5)
  end
end