class Message < ActiveRecord::Base
  belongs_to :conference
  belongs_to :user  
  paginates_per 20
  validates :text, length:{ minimum: 1, maximum: 500 }

end
