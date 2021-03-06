class Auction < ActiveRecord::Base
  belongs_to :product
  has_one :category, through: :product
  has_many :bids
  has_many :users, through: :bids

  validates :starting_price, presence: true

  def self.active
    where('starting_time <= ?', Time.now)
        .where('ending_time >= ?', Time.now)
  end

  def winning_bid_amount
    bid = bids.max_by { |bid| bid.amount }
    bid.amount
  end

  def winner
    if bids.empty?
      "-"
    else
      bids.last.user.full_name
    end
  end

  def status
    if (starting_time <= Time.now) && (ending_time >= Time.now)
      "active"
    elsif starting_time >= Time.now
      "scheduled"
    else
      "ended"
    end
  end

  def self.search(search)
    joins(:product).where("name ILIKE ?", "%#{search}%")
  end
end
