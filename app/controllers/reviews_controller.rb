class ReviewsController < ApplicationController
  DEFAULT_TAGS = ['default']

  def index
    products = Product.where(id: params[:product_ids]).sort_by(&:created_at)
    return if products.blank?

    params[:per_page] ||= 10
    per_page = params[:per_page].to_i
    offset = params[:page].to_i * per_page

    data = []
    products.each do |product|
      reviews = product.reviews.sort_by(&:created_at)[offset..(offset + per_page)]
      data << { product: product, reviews: reviews }
    end

    render json: { records: data, success: true }
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
