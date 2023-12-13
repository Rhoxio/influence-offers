class CreateOfferTags < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_tags do |t|
      t.references :tag
      t.references :offer
      t.timestamps
    end

    add_index(:offer_tags, [:tag_id, :offer_id], unique: true)
  end
end
