class AddUserAndAuctionToBids < ActiveRecord::Migration
  def change
    add_reference :bids, :user, index: true, foreign_key: true
    add_reference :bids, :auction, index: true, foreign_key: true
  end
end
