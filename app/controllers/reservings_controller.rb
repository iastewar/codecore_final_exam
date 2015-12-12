class ReservingsController < ApplicationController
  before_action :authenticate_user

  def create
    auction = Auction.find params[:auction_id]

    if auction.reserve_price > auction.winning_price
      redirect_to auction, alert: "Error! Auction reserve is not met." and return
    end

    if auction.reserve
      auction.save
      redirect_to auction, notice: "Reserve Met!"
    else
      redirect_to auction, alert: "Error! Auction reserve is not met."
    end
  end

end
