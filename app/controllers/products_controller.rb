class ProductsController < ApplicationController
  def index
    if shop = Shop.find_by(id: params[:shop_id])
      params[:per_page] ||= 10
      per_page = params[:per_page].to_i
      offset = params[:page].to_i * per_page
      products = shop.products.sort_by(&:created_at)[offset..(offset + per_page)]
      render json: { records: products, success: true }
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product
  end
end
