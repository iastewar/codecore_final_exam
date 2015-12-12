class AddWinningUserToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :winning_user, :integer
  end
end
