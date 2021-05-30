class ShopsController < ApplicationController
  def index
    shops = Shop.order(:name)
    render json: shops
  end
end
