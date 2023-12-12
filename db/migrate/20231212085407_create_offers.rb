class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description

      t.integer :target_age
      t.integer :max_age
      t.integer :min_age

      t.integer :total_claimed, default: 0

      t.timestamps
    end

    add_index :offers, :target_age

  end

  
end
