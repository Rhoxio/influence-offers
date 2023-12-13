class CreateClaimedOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :claimed_offers do |t|
      t.references :player
      t.references :offer
      t.timestamps
    end

    add_index(:claimed_offers, [:player_id, :offer_id], unique: true)
  end
end
