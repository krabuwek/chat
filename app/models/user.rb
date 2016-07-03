class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :message
  has_many :conferences , class_name: :Conference ##шото надо починить тут братка
  devise :database_authenticatable, 
       :registerable,
       :recoverable, 
       :rememberable, 
       :trackable, 
       :validatable
end
