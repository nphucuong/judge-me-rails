class ShopsController < ApplicationController
  def index
    shops = Shop.order(:name)
    render json: { records: shops, success: true }
  end
end
