require 'rails_helper'

RSpec.feature "Auctions", type: :feature do

  context "creating" do
    it "valid params: takes you to the show page / see title / see details / see reserve price" do
      u = FactoryGirl.create(:user)

      visit new_session_path

      fill_in "Email", with: u.email
      fill_in "Password", with: u.password
      click_button "Log In"

      visit new_auction_path

      fill_in "Title", with: "this is the title"
      fill_in "Details", with: "these are details"
      fill_in "Reserve price", with: "100"
      click_button "Create Auction"

      expect(page).to have_text /this is the title/i
      expect(page).to have_text /these are details/i
      expect(page).to have_text /Reserve price/i
      expect(current_path).to eq(auction_path(Auction.last))

    end

    it "invaild params: renders new auction page" do
      u = FactoryGirl.create(:user)

      visit new_session_path

      fill_in "Email", with: u.email
      fill_in "Password", with: u.password
      click_button "Log In"

      visit new_auction_path

      fill_in "Details", with: "these are details"
      click_button "Create Auction"

      expect(current_path).to eq(auctions_path)
    end
  end

end
