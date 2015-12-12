require 'rails_helper'

RSpec.describe "auctions/new", type: :view do
  before(:each) do
    assign(:auction, Auction.new(
      :title => "MyString",
      :details => "MyText",
      :reserve_price => 1.5,
      :current_price => 1.5
    ))
  end

  it "renders new auction form" do
    render

    assert_select "form[action=?][method=?]", auctions_path, "post" do

      assert_select "input#auction_title[name=?]", "auction[title]"

      assert_select "textarea#auction_details[name=?]", "auction[details]"

      assert_select "input#auction_reserve_price[name=?]", "auction[reserve_price]"

      assert_select "input#auction_current_price[name=?]", "auction[current_price]"
    end
  end
end
