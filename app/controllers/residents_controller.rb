# frozen_string_literal: true

class ResidentsController < ApplicationController
  include SetUser
  before_action :authenticate_user!
  before_action :set_resident

  def new; end

  def create
    @resident = Resident.new(resident_params)
    if @resident.save
      redirect_to user_path(current_user), notice: '住所を登録しました'
    else
      render template: 'residents/new'
    end
  end

  def edit; end

  def update
    if @resident.update(resident_params)
      redirect_to user_path(current_user), notice: '住所を更新しました'
    else
      render template: 'residents/new'
    end
  end

  protected

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

  def set_resident
    @resident = @user.resident || Resident.new
    @resident
  end
end
