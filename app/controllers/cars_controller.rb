class CarsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :destroy]
  before_action :find_car, only:[:show, :edit, :update, :destroy]
  before_action :redirect_root, only:[:edit, :update, :destroy]

  def index
    @cars = Car.all.includes(:user).order('created_at DESC')
  end

  def new
    @form = SaveCarsTag.new
  end

  def create
    @form = SaveCarsTag.new(car_params)
    tag_list = params[:car][:name].split(",")
    if @form.valid?
      @form.save(tag_list)
      return redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @form = SaveCarsTag.new(car: @car)
  end

  def update
    @form = SaveCarsTag.new(car_params, car: @car)
    tag_list = params[:car][:name].split(",")
    if @form.valid?
      @form.save(tag_list)
      return redirect_to car_path(@car)
    else
      render :edit
    end
  end

  def destroy
    if @car.destroy
      redirect_to root_path
    end
  end

  private

  def car_params
    params.require(:car).permit(:title, :image, :text, :maker_id, :car_name, :body_type_id, :name).merge(user_id: current_user.id)
  end

  def find_car
    @car = Car.find(params[:id])
  end
  
  def redirect_root
    redirect_to root_path unless current_user == @car.user
  end
end
