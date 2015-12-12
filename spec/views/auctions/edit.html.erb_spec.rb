require 'rails_helper'

RSpec.describe "auctions/edit", type: :view do
  before(:each) do
    @auction = assign(:auction, Auction.create!(
      :title => "MyString",
      :details => "MyText",
      :reserve_price => 1.5,
      :current_price => 1.5
    ))
  end

  it "renders the edit auction form" do
    render

    assert_select "form[action=?][method=?]", auction_path(@auction), "post" do

      assert_select "input#auction_title[name=?]", "auction[title]"

      assert_select "textarea#auction_details[name=?]", "auction[details]"

      assert_select "input#auction_reserve_price[name=?]", "auction[reserve_price]"

      assert_select "input#auction_current_price[name=?]", "auction[current_price]"
    end
  end
end
