class BidsController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create

    bid_params = params.require(:bid).permit(:price)
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new bid_params
    @bid.auction = @auction
    @bid.user = current_user

    if current_user == @auction.user
      redirect_to auction_path(@auction), alert: "You can't bid on your own auction!" and return
    end

    if @bid.price && @bid.price <= @auction.current_price
      redirect_to auction_path(@auction), alert: "Bid price must be higher than current price!" and return
    end

    if @bid.save
      @auction.current_price += 1
      if @bid.price > @auction.winning_price
        @auction.winning_price = @bid.price
        @auction.winning_user = @bid.user.id
      end
      @auction.save
      respond_to do |format|
          format.html {redirect_to auction_path(@auction), notice: "Bid created succussfully!"}
          format.json {render json: {price: @bid.price, name: @bid.user.full_name}}
      end
    else
      @bids = @auction.bids.order(created_at: :desc)
      render "auctions/show"
    end
  end

  def index
    @bids = Bid.order(created_at: :desc)
  end

end
