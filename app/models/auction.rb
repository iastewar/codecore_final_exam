class Auction < ActiveRecord::Base
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :ends_on, presence: true

  include AASM

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserved_met
    state :won
    state :cancelled
    state :reserved_not_met

    event :reserve do
      transitions from: :published, to: :reserved_met
    end

  end

  def self.get_winning_user(user_id)
    find(user_id)
  end

end
