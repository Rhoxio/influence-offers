class Offer < ApplicationRecord
  
  AGE_BOUNDS = 1...125

  validates :title, presence: true
  validates :title, length: {maximum: 80}

  validates :description, length: {maximum: 360}

  validates :target_age, presence: true
  validates :target_age, numericality: {in: AGE_BOUNDS}
  validates :max_age, numericality: {in: AGE_BOUNDS}
  validates :min_age, numericality: {in: AGE_BOUNDS}

  before_validation :assign_default_max_and_min

  private

  # I am doing this to ensure that there is always a range to work with.
  # The UI on the backend will see it as required, but I don't want
  # a wayward expectation to leave nil columns. +-1 seems reasonable
  # and falls in line with birthday math for better or worse, so it's
  # kind of an interpretation point. 

  # I really just did this for data consitency, as they aren't strictly "required" but
  # greatly simplifies the Suggestion system from edge casing when I go to build it.
  def assign_default_max_and_min
    if target_age
      self.max_age = (target_age + 1) if max_age.nil?
      self.min_age = (target_age - 1) if min_age.nil?
    end
  end

end