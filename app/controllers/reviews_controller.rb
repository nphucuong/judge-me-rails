class ReviewsController < ApplicationController

  DEFAULT_TAGS = ['default']

  def index
    if shop = Shop.find_by(id: params[:shop_id])
      params[:per_page] ||= 10
      offset = params[:page].to_i * params[:per_page]

      @data = []
      products = shop.products.sort_by(&:created_at)[offset..(offset + params[:per_page])]
      products.each do |product|
        reviews = product.reviews.sort_by(&:created_at)[offset..(offset + params[:per_page])]
        @data << { product: product, reviews: reviews }
      end
    end
  end

  def create
    # TODO: Create reviews in background. No need to show errors (if any) to users, it's fine to skip creating the review silently when some validations fail.

    tags = tags_with_default(params)
    Review.create(product_id: params[:product_id], body: params[:body], rating: params[:rating], reviewer_name: params[:reviewer_name], tags: tags)

    flash[:notice] = 'Review is being created in background. It might take a moment to show up'
    redirect_to action: :index, shop_id: Product.find_by(id: params[:product_id]).shop_id
  end

  private

  # Prepend params[:tags] with tags of the shop if present or DEFAULT_TAGS
  def tags_with_default(params)
    product = Product.find_by(id: params[:product_id])
    default_tags = product.shop.tags || DEFAULT_TAGS
    default_tags.concat(params[:tags].split(',')).uniq
  end

end
