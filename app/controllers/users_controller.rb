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

  def friends
    @user = current_user

    if params[:friend].present?
      symbol = params[:friend].downcase
      @friend = User.find_by(email: symbol)
      @symbol = symbol unless @friend

      render turbo_stream: turbo_stream.replace("results_turbo_stream", partial: "users/friend_result")
    end
  end

  def remove_friend
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])

    Friendship.find_by(user: @user, friend: @friend).destroy

    redirect_to friends_path
  end
end
