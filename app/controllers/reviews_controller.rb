class ReviewsController < ApplicationController
  DEFAULT_TAGS = ['default']

  def index
    if shop = Shop.find_by(id: params[:shop_id])
      params[:per_page] ||= 10
      offset = params[:page].to_i * params[:per_page]

      data = []
      products = shop.products.sort_by(&:created_at)[offset..(offset + params[:per_page])]
      products.each do |product|
        reviews = product.reviews.sort_by(&:created_at)[offset..(offset + params[:per_page])]
        data << { product: product, reviews: reviews }
      end

      render json: { record: data, success: true }
    end
  end

  def create
    tags = tags_with_default(params)
    review_params[:tags] = tags
    ReviewCreator.perform_async(review_params.to_h)
    render json: { success: true }
  end

  private

  # Prepend params[:tags] with tags of the shop if present or DEFAULT_TAGS
  def tags_with_default(params)
    product = Product.find_by(id: params[:product_id])
    product.shop.tags || DEFAULT_TAGS
  end

  def review_params
    params.permit(:product_id, :body, :rating, :reviewer_name, :tags)
  end
end
