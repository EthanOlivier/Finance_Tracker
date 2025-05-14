class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks
  end

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
      @friends = User.lookup(symbol)
      @friends.delete_if { |friend| friend.id == @user.id }
      @symbol = symbol if @friends.to_a.empty?

      render turbo_stream: turbo_stream.replace("results_turbo_stream", partial: "friends/result")
    end
  end

  def create_friend
    Friendship.create(user_id: params[:id], friend_id: params[:friend_id])
    flash[:notice] = "Successfully followed friend"
    redirect_to friends_path
  end

  def remove_friend
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])

    Friendship.find_by(user: @user, friend: @friend).destroy

    redirect_to friends_path
  end
end
