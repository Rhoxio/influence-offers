class CreateClaimedOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :claimed_offers do |t|
      t.references :player, index: true
      t.references :offer, index: true
      t.timestamps
    end
  end
end
