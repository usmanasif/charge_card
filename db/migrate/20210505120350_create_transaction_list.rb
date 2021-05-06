class CreateTransactionList < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_lists, id: :uuid do |t|
      t.uuid :card_id
      t.boolean :approved
      t.string :merchant_name
      t.string :merchant_category
      t.decimal :amount, precision: 10, scale: 2
      t.string :authorization_id

      t.timestamps
    end

    add_index :transaction_lists, :authorization_id, unique: true
  end
end
