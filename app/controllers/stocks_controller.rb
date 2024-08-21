# app/controllers/stocks_controller.rb
class StocksController < ApplicationController
  def index
    @stock_prices = LatestStockPrice.price_all
  end

  def show
    @stock_price_search = LatestStockPrice.price(params[:Search])
  end

  def prices
    @prices = LatestStockPrice.prices(
      isin: params[:isin],
      only_index: params[:only_index],
      indices: params[:indices]
    )
  end
end
