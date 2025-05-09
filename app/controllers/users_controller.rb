class UsersController < ApplicationController
  before_action :authenticate_user!
  def portfolio
    @user = current_user

    if @user.stocks.any?
      @user.stocks.each do |stock|
        stock.price = Stock.update_price(stock)
      end
    end

    if params[:stock].present?
      symbol = params[:stock].upcase
      @stock = Stock.lookup(symbol)

      render turbo_stream: turbo_stream.replace("results_turbo_stream", partial: "users/result")
    end
  end
end
