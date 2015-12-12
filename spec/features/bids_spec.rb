require 'rails_helper'

RSpec.feature "Bids", type: :feature do
  context "creating" do
    it "valid bid: shows the bid and user on the page / redirects to auction page" do
      u = FactoryGirl.create(:user)
      auction = FactoryGirl.create(:auction, user: u, current_price: 0)

      visit new_session_path

      fill_in "Email", with: u.email
      fill_in "Password", with: u.password
      click_button "Log In"

      visit auction_path(Auction.last)

      fill_in "Price", with: "100"
      click_button "Create Bid"

      expect(current_path).to eq(auction_path(Auction.last))
      expect(page).to have_text /1/i
      expect(page).to have_text /#{u.first_name}/i
      expect(page).to have_text /#{u.last_name}/i

    end

    it "invalid bid: doesn't show the bid on the page / doesn't update current value" do
      u = FactoryGirl.create(:user)
      auction = FactoryGirl.create(:auction, current_price: 100)

      visit new_session_path

      fill_in "Email", with: u.email
      fill_in "Password", with: u.password
      click_button "Log In"

      visit auction_path(Auction.last)

      fill_in "Price", with: "1"
      click_button "Create Bid"

      expect(current_path).to eq(auction_path(Auction.last))
      expect(page).to have_text /1/i

    end
  end

end
