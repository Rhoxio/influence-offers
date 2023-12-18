class RemoveTargetGenderFromOffers < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :target_gender, :string
  end
end
