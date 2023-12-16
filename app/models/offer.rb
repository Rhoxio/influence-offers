class Offer < ApplicationRecord

  AGE_BOUNDS = 1..125
  GENDERS = ["male", "female", "nonbinary", "declined"].freeze

  validates :title, presence: true
  validates :title, length: {maximum: 80}

  validates :description, length: {maximum: 400}

  validates :target_age, presence: true
  validates :target_age, numericality: {in: AGE_BOUNDS}
  validates :max_age, numericality: {in: AGE_BOUNDS}
  validates :min_age, numericality: {in: AGE_BOUNDS}

  validates :target_gender, presence: true
  validates :target_gender, inclusion: {in: GENDERS, message: "Invalid gender specified"}  

  before_validation :assign_default_max_and_min
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  # NEED TO ADD A BEFORE SAVE TO CHECK IF THE target_age is in between min and max!
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  # Using dependent: :destroy to keep data cleaner in the scope of this app.
  has_many :claimed_offers, dependent: :destroy
  has_many :players, through: :claimed_offers

  has_many :offer_tags, dependent: :destroy
  has_many :tags, through: :offer_tags

  scope :targeting, ->(gender){ where(target_gender: gender)}
  scope :not_targeting, ->(gender){ where("target_gender != ?", gender)}

  scope :in_age_range, ->(age){where("min_age <= ? AND max_age >= ?", age, age)}

  private

  # I am doing this to ensure that there is always a range to work with.
  # The UI on the backend will see it as required, but I don't want
  # a wayward expectation to leave nil columns. 1 in each direction seems reasonable even 
  # if they were trying to specifically target 18 year old high school seniors or something.
  # Something something birthday math...

  # I really just did this for data consitency, as they aren't strictly "required" but
  # greatly simplifies the Suggestion system from edge casing when I go to build it too.
  def assign_default_max_and_min
    if target_age
      self.max_age = (target_age + 1) if max_age.nil?
      self.min_age = (target_age - 1) if min_age.nil?
    end
  end

end