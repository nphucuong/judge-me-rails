# frozen_string_literal: true

require 'test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ReviewsController, type: :controller do
  let(:product) { create(:product) }

  describe '#create' do
    context 'new review' do
      before do
        post :create, params: {
          product_id: product.id,
          reviewer_name: 'Cuong',
          rating: 2.5,
          body: 'Hope I pass'
        }
      end

      it 'ReviewCreator should be enqueued' do
        expect(ReviewCreator).to have_enqueued_sidekiq_job(
          {
            'product_id' => product.id.to_s,
            'body' => 'Hope I pass',
            'rating' => '2.5',
            'reviewer_name' => 'Cuong'
          }
        )
      end
    end
  end

  describe '#create_review' do
    before do
      params = {
        'product_id' => product.id.to_s,
        'body' => 'Hope I pass',
        'rating' => '2.5',
        'reviewer_name' => 'Cuong'
      }

      ReviewCreator.new.perform(params)
    end

    it 'should be saved' do
      expect(Review.count).to eq 1
    end
  end
end
