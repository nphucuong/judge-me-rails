class ReviewsController < ApplicationController
  DEFAULT_TAGS = ['default']

  def index
    # Elimiate N + 1 with includes review
    products = Product.where(id: params[:product_ids]).includes(:reviews).order(:created_at)
    return if products.blank?

    per_page = (params[:per_page] ||= 10).to_i
    page = params[:page].to_i + 1
    data = []

    products.each do |product|
      reviews = product.reviews.order(:created_at).page(page).per(per_page)
      data << { product: product, reviews: reviews, total_reviews: reviews.total_count }
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
