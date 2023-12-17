class Offer < ApplicationRecord

  AGE_BOUNDS = 1..125
  GENDERS = ["male", "female", "nonbinary", "declined"].freeze

  validates :title, presence: true
  validates :title, length: {maximum: 80}

  validates :description, length: {maximum: 400}

  validates :target_age, presence: true
  validates :target_age, numericality: {in: AGE_BOUNDS}

  validates :max_age, presence: true
  validates :max_age, numericality: {in: AGE_BOUNDS}

  validates :min_age, presence: true
  validates :min_age, numericality: {in: AGE_BOUNDS}

  validates :target_gender, presence: true
  validates :target_gender, inclusion: {in: GENDERS, message: "Invalid gender specified"}  

  # Using dependent: :destroy to keep data cleaner in the scope of this app.
  # Might leave this in for metrics in larger apps (or add soft delete or something), 
  # but we aren't running metrics here and it makes dealing with the data far easier.
  has_many :claimed_offers, dependent: :destroy
  has_many :players, through: :claimed_offers

  has_many :offer_tags, dependent: :destroy
  has_many :tags, through: :offer_tags

  scope :targeting, ->(gender){ where(target_gender: gender)}
  scope :not_targeting, ->(gender){where("target_gender != ?", gender)}
  scope :in_age_range, ->(age){where("min_age <= ? AND max_age >= ?", age, age)}


end