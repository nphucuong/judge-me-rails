class ShopsController < ApplicationController
  def index
    shops = Shop.order(:name)
    render json: shops
  end

  def report
    shop = Shop.find_by(id: params[:id])
    average_by_month_shop_rating = shop.products.joins(:reviews)
                                       .group("DATE_TRUNC('month', reviews.created_at)")
                                       .average(:rating)

    result = []
    average_by_month_shop_rating.each_with_index do |(_month, current_month_rating), index|
      last_month_rating = average_by_month_shop_rating.to_a[index + 1]&.last || 0
      result << (current_month_rating - last_month_rating).to_f
    end

    render json: { average_by_month_shop_rating: average_by_month_shop_rating, result: result }
  end
end
