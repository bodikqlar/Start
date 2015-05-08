class Movie < ActiveRecord::Base
  #-----------Associations------------
  has_and_belongs_to_many :categories
  belongs_to :user

  #-----------Validations------------
  validates :name, presence: true
end
