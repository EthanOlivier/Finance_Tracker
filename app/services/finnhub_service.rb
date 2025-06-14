require "httparty"

class FinnhubService
  include HTTParty
  base_uri "https://finnhub.io/api/v1"

  def initialize
    @api_key = ENV["FINNHUB_API_KEY"]
  end

  def quote(symbol)
    self.class.get("/quote", query: { symbol: symbol, token: @api_key })
  end

  def company_profile(symbol)
    self.class.get("/stock/profile2", query: { symbol: symbol, token: @api_key })
  end
end
