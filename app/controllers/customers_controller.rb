# frozen_string_literal: true

class CustomersController < ApplicationController
  include SetUser
  before_action :authenticate_user!
  before_action :user_customer, only: [:new]

  def show
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @customer = Payjp::Customer.retrieve(user_customer.customer_id)
    @cards = @customer.cards.data
    puts @customer
  end

  def new; end

  def create
    customer_id = user_customer.customer_id
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # カード情報を登録
    customer = Payjp::Customer.retrieve(customer_id)
    begin
      customer.cards.create(card: params['payjpToken'])
    rescue Payjp::InvalidRequestError => e
      logger.error e
      redirect_to new_customer_url, alert: "カード情報が正しくないか，すでに登録されています"
      return
    end
    redirect_to customer_path(current_user.customer), notice: "カードが登録されました"
  end

  private

  # 顧客情報を取得 or 登録
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
