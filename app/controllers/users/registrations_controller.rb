# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def phone; end

  def resident
    @resident = Resident.new
  end

  def resident_registration
    @resident = Resident.new(resident_params)
    if @resident.save
      redirect_to customer_registration_url
    else
      render action: "resident"
    end
  end

  def customer
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    api_customer = Payjp::Customer.create(
      description: current_user.id,
      email: current_user.email
    )
    customer = Customer.create(customer_id: api_customer.id, user_id: current_user.id)
  end

  def customer_registration
    customer_id = current_user.customer.customer_id
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # カード情報を登録
    customer = Payjp::Customer.retrieve(customer_id)
    begin
      customer.cards.create(card: params['payjpToken'])
    rescue Payjp::InvalidRequestError => e
      logger.error e
      redirect_to action: "customer", alert: "カード情報が正しくないか，すでに登録されています"
      return
    end
    redirect_to complete_url
  end

  def complete; end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[attribute nickname])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute nickname])
  end

  # The path used after sign up.
  def after_sign_up_path_for(_resource)
    phone_registration_url
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def resident_params
    params.require(:resident).permit(
      :real_first_name,
      :real_last_name,
      :kana_first_name,
      :kana_last_name,
      :birthday,
      :zip_code,
      :prefecture,
      :city_name,
      :house_number,
      :building_name,
      :phone_number
    ).merge(user_id: current_user.id)
  end
end
