class Offer < ApplicationRecord

  AGE_BOUNDS = 1..125
  GENDERS = ["male", "female", "nonbinary", "declined"].freeze

  validates :title, presence: true
  validates :title, length: {maximum: 80}

  validates :description, length: {maximum: 400}

  validates :target_age, presence: true
  validates :target_age, numericality: {in: AGE_BOUNDS}
  validates_with OfferTargetAgeRangeValidator

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

  # I originally went with a counted version that used before_save/incrementors to store the count in a column
  # I opted against that because it wasn't strictly required for performance purposes and
  # was making the Player and Offer callback bloat too much to bear for such simple functionality.
  # If the app was larger, I would have architecture set up to make sure that the counts get updated
  # and stored using a sidekiq task or callbacks - depends on request throughput, read vs write, and importance
  # of real-time data versus cached or estimated data.

  # Keeping it simple seemed to just be a better idea here. Response times are fine in the 'suggestion'
  # feature code, and worst-case I could write a query to make it faster. Going with the simple utility of
  # a query method for the moment, though. 
  def total_claimed
    self.players.count
  end


end