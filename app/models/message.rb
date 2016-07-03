class Message < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "sender_id"
  belongs_to :user, class_name: "User", foreign_key: "recipient_id"
  paginates_per 10
end
