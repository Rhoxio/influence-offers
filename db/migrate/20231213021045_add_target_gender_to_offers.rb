class AddTargetGenderToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :target_gender, :string
  end
end
