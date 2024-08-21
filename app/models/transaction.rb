# app/models/transaction.rb
class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: ['debit', 'credit'] }
  validate :validate_wallets

  private

  def validate_wallets
    errors.add(:base, 'Source wallet must be present for debits') if transaction_type == 'debit' && source_wallet.nil?
    errors.add(:base, 'Target wallet must be present for credits') if transaction_type == 'credit' && target_wallet.nil?
  end
end
