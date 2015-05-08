class Category < ActiveRecord::Base
  #-----------Associations------------
  has_and_belongs_to_many :movies

  #-----------Validations------------
  validates :name, presence: true
end
