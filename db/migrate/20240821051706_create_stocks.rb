class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
