class UserStocksController < ApplicationController
  def create
    stock = Stock.where(ticker: params[:ticker]).first
    if stock.blank?
      stock = Stock.lookup(params[:ticker])
      stock.save
    end
    UserStock.create(user: User.find(params[:user]), stock: stock)
    flash[:notice] = "Successfully added stock to your portfolio"
    redirect_to portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    UserStock.where(user_id: current_user.id, stock_id: stock.id).first.destroy
    flash[:notice] = "Successfully removed #{stock.ticker} from portfolio"
    redirect_to portfolio_path
  end
end
