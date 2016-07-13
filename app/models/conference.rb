class Conference < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages

  def inc_subscribers
    self.subscribers = self.subscribers + 1
  end

  def deinc_subscribers
    self.subscribers = self.subscribers - 1
  end
end
