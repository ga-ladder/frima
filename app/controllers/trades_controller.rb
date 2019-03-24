class TradesController < ApplicationController
  def new
    @trade = Trade.new
    @product = Product.find(params[:product_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.retrieve(user_customer.customer_id)
    @default_card = customer.default_card
    @card = customer.cards.retrieve(@default_card) if @default_card

  end

  def create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.retrieve(user_customer.customer_id)
    charge = Payjp::Charge.create(
        amount: Product.find(params[:product_id]).price,
        card: customer.default_card,
        customer: customer.id,
        currency: 'jpy',
        description: "product_id:" + params[:product_id].to_s
      )
    @trade = Trade.new(product_id: params[:product_id], user_id: current_user.id, charge_id: charge.id)
    if @trade.save
      redirect_to product_url(params[:product_id]), notice: "購入完了"
    else
      render "/products/#{params[:product_id]}/trades/new", alert: @trade.errors.full_messages
    end
  end

  protected
  def user_customer
    if current_user.customer
      customer = current_user.customer
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      api_customer = Payjp::Customer.create(
        description: current_user.id,
        email: current_user.email
      )
      customer = Customer.create(customer_id: api_customer.id, user_id: current_user.id)
    end
    customer
  end
end
