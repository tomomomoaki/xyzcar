class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :cars
  has_many :comments
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'send_user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'transmitted_user_id', dependent: :destroy

end
