class ProductsController < ApplicationController
  def index
    shop = Shop.find_by(id: params[:shop_id])
    return render json: { success: false }, status: 400 if shop.nil?

    per_page = (params[:per_page] ||= 10).to_i
    page = params[:page].to_i + 1
    products = shop.products.order(:created_at).page(page).per(per_page)
    render json: { records: products, total: products.total_count }
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product
  end
end
