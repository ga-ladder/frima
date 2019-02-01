class UsersController < ApplicationController

  def login_way
    @user ||= User.new
  end
end
