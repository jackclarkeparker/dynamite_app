class ChangePriceToDecimalOnLessons < ActiveRecord::Migration[7.0]
  def change
    change_column :lessons, :standard_price, :decimal, precision: 4, scale: 2
  end
end
