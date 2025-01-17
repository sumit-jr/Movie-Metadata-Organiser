class AddMoreColsToMovie < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :paid, :boolean
    add_column :movies, :stripe_price_id, :string
    add_column :movies, :premium_description, :text
  end
end
