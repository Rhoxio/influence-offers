class CreateGenders < ActiveRecord::Migration[7.1]
  def change
    create_table :genders do |t|
      t.string :name
      t.string :label
      t.timestamps
    end

    create_table :offer_genders do |t|
      t.references :offer
      t.references :gender
    end
    add_index(:offer_genders, [:gender_id, :offer_id], unique: true)
  end
end
