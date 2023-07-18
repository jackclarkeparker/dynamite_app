class AddStandardPriceToVenues < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :standard_price, :decimal, precision: 4, scale: 2
  end
end
