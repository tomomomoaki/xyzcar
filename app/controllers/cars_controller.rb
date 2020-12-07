class CarsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :redirect_root, only: [:edit, :update, :destroy]
  before_action :scraping_info, only: [:index, :search, :type]
  before_action :notice_notification, only: [:index, :new, :show, :edit, :search, :type]

  def index
    @cars = Car.all.includes(:user, :tags).order('created_at DESC').page(params[:page])
    #ランキング上位3つを取り出す
    @tags = Tag.find(CarTag.group(:tag_id).order('count(tag_id) desc').limit(3).pluck(:tag_id))
    @makers = Car.group(:maker_id).order('count(maker_id) desc').limit(3)
    @bodytypes = Car.group(:body_type_id).order('count(body_type_id) desc').limit(3)
  end

  def new
    @form = SaveCarsTag.new
  end

  def create
    @form = SaveCarsTag.new(car_params)
    tag_list = params[:car][:name].split(',')
    if @form.valid?
      @form.save(tag_list, [])
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @car.comments.order('created_at desc')
    if params[:notification_id]
      @notification = Notification.where(params[:notification_id])
      @notification.update(notice: 'true')
    end
  end

  def edit
    @form = SaveCarsTag.new(car: @car)
  end

  def update
    @form = SaveCarsTag.new(car_params, car: @car)
    old_images = []
    old_images_id = params[:car][:old_ids].split(',')
    old_images_id.each do |id|
      old_images << @car.images[id.to_i]
    end
    tag_list = params[:car][:name].split(',')
    if @form.valid?
      @form.save(tag_list, old_images)
      redirect_to car_path(@car)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @car.destroy
  end

  def search_tag
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE(?)', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  def search
    if params[:keyword] == ''
      redirect_to root_path
    elsif (params[:keyword])[0] == '#'
      @cars = Tag.search(params[:keyword]).order('created_at DESC').page(params[:page])
    else
      @cars = Car.search(params[:keyword]).order('created_at DESC').page(params[:page])
    end
  end

  def type
    if params[:keyword] == ''
      @cars = Car.all.includes(:user, :tags).order('created_at DESC').page(params[:page])
    else
      search
    end

    if (params[:maker_id] == '1') && (params[:body_type_id] == '1') && (params[:car_name] == '')
      render 'search'
    else
      @cars = Car.type(params, @cars).order('created_at DESC').page(params[:page])
      render 'search'
    end
  end

  private

  def car_params
    params.require(:car).permit(:title, :old_ids, { images: [] }, :text, :maker_id, :car_name, :body_type_id, :name).merge(user_id: current_user.id)
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def redirect_root
    redirect_to root_path unless current_user == @car.user
  end

  def scraping_info
    @elements = Scraping.get_url
  end

  def notice_notification
    @notifications = Notification.where(transmitted_user_id: current_user.id).where(notice: 'false') if user_signed_in?
  end
end
