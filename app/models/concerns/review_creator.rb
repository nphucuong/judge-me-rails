class ReviewCreator
  include Sidekiq::Worker
  extend ActiveSupport::Concern

  def perform(params)
    create_review(params)
  end

  def create_review(params)
    product = Product.find_by(id: params['product_id'])
    return if product.nil?

    Review.create(params)
  end
end
