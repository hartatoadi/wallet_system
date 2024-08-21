# lib/latest_stock_price.rb
require 'net/http'
require 'json'
require 'uri'

class LatestStockPrice
  BASE_URL = "https://latest-stock-price.p.rapidapi.com"

  def self.price(symbol)
    response = request("/equities-search", Search: symbol)
    parse_response(response)
  end

  def self.prices(isin: nil, only_index: nil, indices: nil)
    params = {}
    params[:ISIN] = isin if isin
    params[:OnlyIndex] = only_index if only_index
    params[:Indicies] = indices if indices

    response = request("/equities", params)
    parse_response(response)
  end

  def self.price_all
    response = request("/any")
    parse_response(response)
  end

  private

  def self.request(endpoint, params = {})
    uri = URI("#{BASE_URL}#{endpoint}")
    uri.query = URI.encode_www_form(params) unless params.empty?

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true # Ensure HTTPS is used

    request = Net::HTTP::Get.new(uri)
    request["X-RapidAPI-Key"] = ENV['RAPIDAPI_KEY'] # Use ENV variable for security
    request["X-RapidAPI-Host"] = "latest-stock-price.p.rapidapi.com"

    http.request(request)
  end

  def self.parse_response(response)
    if response.is_a?(Net::HTTPSuccess) && response.body.present?
      JSON.parse(response.body)
    else
      {}
    end
  end
end
