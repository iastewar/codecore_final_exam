class AddWinningPriceToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :winning_price, :float
  end
end
