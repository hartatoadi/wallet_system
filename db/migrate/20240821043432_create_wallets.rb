# db/migrate/YYYYMMDDHHMMSS_create_wallets.rb
class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.string :type
      t.decimal :balance, precision: 10, scale: 2
      t.references :entity, polymorphic: true, null: false

      t.timestamps
    end
  end
end
