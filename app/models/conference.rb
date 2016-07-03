class Conference < ActiveRecord::Base
  belongs_to :users
  has_many :messages
end
