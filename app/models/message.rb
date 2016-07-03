class Message < ActiveRecord::Base
  belongs_to :conference
  belongs_to :user  
  paginates_per 10
end
