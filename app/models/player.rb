class Player < ApplicationRecord

  GENDERS = ["male", "female", "nonbinary", "declined"]
  AGE_RANGE = 1...125

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :gender, presence: true
  validates :gender, inclusion: {in: GENDERS, message: "Invalid gender specified"}
  
  validates :age, presence: true
  validates :age, numericality: {in: AGE_RANGE}


  # def ransackable_associations(auth_object = nil)
  #   []
  # end         
end
