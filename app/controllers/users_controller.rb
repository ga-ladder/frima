# frozen_string_literal: true

class UsersController < ApplicationController
  include SetUser
  before_action :user_customer, only: [:show]

  def show; end

  def destroy; end

  def sign_up_way
    @user ||= User.new
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
