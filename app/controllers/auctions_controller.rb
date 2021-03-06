class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.order(created_at: :desc)
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
    @bids = @auction.bids.order(created_at: :desc)
    @bid = Bid.new
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
    redirect_to auction_path(@auction), alert: "Access denied." and return unless can? :edit, @auction
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)

    @auction.user = current_user

    @auction.current_price = 0;
    @auction.winning_price = 0;

    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    redirect_to auction_path(@auction), alert: "Access denied." and return unless can? :update, @auction
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    redirect_to auctions_path(@auction), alert: "Access denied." and return unless can? :destroy, @auction

    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
    end
end
