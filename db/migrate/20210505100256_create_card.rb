class CreateCard < ActiveRecord::Migration[6.1]
  def change
    create_table :cards, id: :uuid do |t|
      t.string :name
      t.string :last4
      t.string :expiry_month
      t.string :expiry_year
      t.string :issuing_card_id
      t.integer :status
      t.string :currency
      t.string :card_type

      t.timestamps
    end

    add_index :cards, :issuing_card_id, unique: true
  end
end
