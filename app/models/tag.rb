class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {maximum: 20}

  before_save :generate_slug

  has_many :offer_tags, dependent: :destroy
  has_many :offers, through: :offer_tags

  private

  def generate_slug
    # Slug scheme is lowercase underscore delimited essentially.
    # Doing this so we have a consistent terminology lookup and
    # non-spaced formatted data in case we need to run text queries.
    self.slug = name.parameterize.underscore if name
  end
end
