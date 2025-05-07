class UsersController < ApplicationController
  before_action :authenticate_user!
  def portfolio
    @user = current_user

    if params[:stock].present?
      symbol = params[:stock].upcase
      service = FinnhubService.new
      profile = service.company_profile(symbol)
      quote = service.quote(symbol)

      @stock = Stock.new(ticker: symbol, name: profile["name"], price: quote["c"])

      render turbo_stream: turbo_stream.replace("results_turbo_stream", partial: "users/result")
    end
  end
end
