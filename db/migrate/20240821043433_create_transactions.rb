class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :transaction_type
      t.references :source_wallet, foreign_key: { to_table: :wallets }, null: true
      t.references :target_wallet, foreign_key: { to_table: :wallets }, null: true

      t.timestamps
    end
  end
end
