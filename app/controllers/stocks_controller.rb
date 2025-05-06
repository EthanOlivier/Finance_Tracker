class StocksController < ApplicationController
  def show
    if params[:symbol].present?
      @symbol = params[:symbol].upcase
      service = FinnhubService.new
      @quote = service.quote(@symbol)
      @profile = service.company_profile(@symbol)
    else
      flash[:error] = "Symbol is required."
      redirect_to root_path
    end
  end
end
