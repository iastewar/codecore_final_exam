class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :price, presence: true
end
