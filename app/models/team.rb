# app/models/team.rb
class Team < ApplicationRecord
  has_one :wallet, as: :entity, dependent: :destroy
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(entity: self, balance: 0)
  end
end
