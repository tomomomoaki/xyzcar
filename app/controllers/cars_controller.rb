class CarsController < ApplicationController
  before_action :authenticate_user!, only:[:new]

  def index
    @cars = Car.all.includes(:user).order('created_at DESC')
  end

  def new
    @car = SaveCarsTag.new
  end

  def create
    @car = SaveCarsTag.new(car_params)
    if @car.valid?
      @car.save
      return redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private

  def car_params
    params.require(:save_cars_tag).permit(:title, :image, :text, :maker_id, :car_name, :body_type_id, :name).merge(user_id: current_user.id)
  end
  
end
