class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.lookup(symbol)
    service = FinnhubService.new
    profile = service.company_profile(symbol)
    quote = service.quote(symbol)
    Stock.new(ticker: symbol, name: profile["name"], price: quote["c"])
  end
end
