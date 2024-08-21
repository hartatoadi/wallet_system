# app/models/wallet.rb
class Wallet < ApplicationRecord
  self.inheritance_column = :type
  belongs_to :entity, polymorphic: true
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def update_balance(amount, source_wallet: nil, target_wallet: nil)
    ActiveRecord::Base.transaction do
      if source_wallet
        source_wallet.update!(balance: source_wallet.balance - amount)
        Transaction.create!(amount: amount, transaction_type: 'debit', source_wallet: source_wallet, target_wallet: nil)
      end
      if target_wallet
        target_wallet.update!(balance: target_wallet.balance + amount)
        Transaction.create!(amount: amount, transaction_type: 'credit', source_wallet: nil, target_wallet: target_wallet)
      end
    end
  end
end
