class NotificationsController < ApplicationController

  def index
  end

  def search_notification
    notifications = Notification.where(transmitted_user_id: current_user.id).order('created_at desc')
    send_user_names =[]
    notifications.each do |notification|
      send_user_names << notification.send_user.nickname
    end
    render json: {notifications: notifications, send_user_names: send_user_names} 
  end
end
