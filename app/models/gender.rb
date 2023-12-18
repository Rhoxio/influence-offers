class Gender < ApplicationRecord
  GENDERS = ["male", "female", "nonbinary", "declined"].freeze
  LABELS = ["Male", "Female", "Non-Binary", "Declined to Answer"].freeze

  validates :name, presence: true
  validates :name, inclusion: {in: GENDERS, message: "Invalid gender specified"}  

  validates :label, presence: true
  validates :label, inclusion: {in: LABELS, message: "Invalid gander label specified"}  

  has_many :offer_genders, dependent: :destroy
  has_many :offers, through: :offer_genders  
end