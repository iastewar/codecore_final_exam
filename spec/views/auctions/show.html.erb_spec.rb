require 'rails_helper'

RSpec.describe "auctions/show", type: :view do
  before(:each) do
    @auction = assign(:auction, Auction.create!(
      :title => "Title",
      :details => "MyText",
      :reserve_price => 1.5,
      :current_price => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
  end
end
