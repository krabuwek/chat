class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :messages
  has_and_belongs_to_many :conferences ##шото надо починить тут братка
  devise :database_authenticatable, 
       :registerable,
       :recoverable, 
       :rememberable,
       :trackable, 
       :validatable

  def appear
    self.online = 0
  end

  def disappear
    self.online = 1
  end

end
