class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @cars = @user.cars.order('created_at DESC').page(params[:page])
  end
end
