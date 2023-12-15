class Player < ApplicationRecord

  GENDERS = ["male", "female", "nonbinary", "declined"].freeze
  AGE_RANGE = 1..125

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :gender, presence: true
  validates :gender, inclusion: {in: GENDERS, message: "Invalid gender specified"}
  
  validates :age, presence: true
  validates :age, numericality: {in: AGE_RANGE}

  # Using dependent: :destroy to keep data cleaner for this situation.
  has_many :claimed_offers, dependent: :destroy
  has_many :offers, through: :claimed_offers

  # scope :claimed_offers, -> {joins(:claimed_offers).where('player_id = player.id')}


  # private
  # def ransackable_associations(auth_object = nil)
  #   []
  # end         
end
