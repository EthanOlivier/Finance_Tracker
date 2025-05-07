class UsersController < ApplicationController
  def portfolio
    @user = current_user

    if params[:stock].present?
      symbol = params[:stock].upcase
      service = FinnhubService.new
      profile = service.company_profile(symbol)
      quote = service.quote(symbol)

      @stock = Stock.new(ticker: symbol, name: profile["name"], price: quote["c"])
    end
  end
end
