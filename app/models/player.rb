class Player < ApplicationRecord

  GENDERS = ["male", "female", "nonbinary", "declined"].freeze
  AGE_RANGE = 1..125

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :gender, presence: true
  validates :gender, inclusion: {in: GENDERS, message: "Invalid gender specified"}
  
  validates :age, presence: true
  validates :age, numericality: {in: AGE_RANGE}

  # Using dependent: :destroy to keep data cleaner in the scope of this app.
  # Might leave this in for metrics in larger apps (or add soft delete or something), 
  # but we aren't running metrics here and it makes dealing with the data far easier.  
  has_many :claimed_offers, dependent: :destroy
  has_many :offers, through: :claimed_offers

  # private

  # def ransackable_associations(auth_object = nil)
  #   []
  # end         
end
