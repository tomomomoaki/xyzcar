class Notification < ApplicationRecord

  belomgs_to :car, optional: true
  belongs to :comment, optional: true

  belongs_to :send_user, class_name: 'User', foreign_key: 'send_user_id', optional: true
  belongs_to :transmitted_user, class_name: 'User', foreign_key: 'transmitted_user_id', optional: true
end
