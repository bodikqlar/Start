class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #-------------Associations-------------
  has_many :movies, dependent: :destroy
end
