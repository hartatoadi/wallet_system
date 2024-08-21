class EnsureDefaultUser < ActiveRecord::Migration[7.2]
  def up
    unless User.exists?(email: 'defaultuser@example.com')
      User.create!(
        email: 'defaultuser@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end
  end

  def down
    User.where(email: 'defaultuser@example.com').delete_all
  end
end
