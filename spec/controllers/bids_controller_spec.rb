require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  let(:auction) {FactoryGirl.create(:auction, user: user, current_price: 0, winning_price: 0)}


  describe "POST #create" do
    context "with no user signed in" do
      it "redirects to the sign in page" do
        post :create, {auction_id: auction.id, bid: {}} # params don't matter here becuase the
                                     # controller should redirect before making
                                     # use of the bid params
        expect(response).to redirect_to new_session_path
      end
    end

    context "With user signed in" do
      def valid_params
        FactoryGirl.attributes_for(:bid)
      end

      u = FactoryGirl.create(:user)

      before do
        request.session[:user_id] = u.id

        auction = FactoryGirl.create(:auction)

      end

      context "with valid parameters" do
        context "price greater than current" do
          it "creates a bid record in the database" do
            before_count = Bid.count
            post :create, {auction_id: auction.id, bid: valid_params}
            after_count  = Bid.count
            expect(after_count - before_count).to eq(1)
          end

          it "associates the bid with the signed in user" do
            post :create, {auction_id: auction.id, bid: valid_params}
            expect(Bid.last.user).to eq(u)
          end

          it "redirects to auction show page" do
            post :create, {auction_id: auction.id, bid: valid_params}
            expect(response).to redirect_to(auction_path(Auction.last))
          end
        end
        context "price less than current" do
          it "doesn't create a bid record in the database" do
            before_count = Bid.count
            post :create, {auction_id: auction.id, bid: {price: 1}}
            post :create, {auction_id: auction.id, bid: {price: 0}}
            after_count  = Bid.count
            expect(after_count - before_count).to eq(1)
          end

          it "redirects to auction show page" do
            post :create, {auction_id: auction.id, bid: valid_params}
            expect(response).to redirect_to(auction_path(Auction.last))
          end
        end

      end
      context "with invalid parameters" do
        def request_with_invalid_title
          post :create, {auction_id: auction.id, bid: valid_params.merge({price: nil})}
        end

        it "doesn't create a bid record in the database" do
          # expect { request_with_invalid_title }.not_to change { Bid.count }
          before_count = Bid.count
          request_with_invalid_title
          after_count  = Bid.count
          expect(before_count).to eq(after_count)
        end

        it "renders the auction template" do
          request_with_invalid_title
          expect(response).to render_template('auctions/show')
        end
      end
    end
  end


end
