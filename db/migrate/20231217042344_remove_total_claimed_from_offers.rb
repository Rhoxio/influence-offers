class RemoveTotalClaimedFromOffers < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :total_claimed
  end
end
