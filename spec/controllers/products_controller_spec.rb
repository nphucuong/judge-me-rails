# frozen_string_literal: true

require 'test_helper'

RSpec.describe ProductsController, type: :controller do
  let(:shop) { create(:shop) }
  let!(:product) { create(:product, shop: shop) }

  describe '#index' do
    context 'valid' do
      before do
        get :index, params: {
          shop_id: shop.id
        }
      end

      it 'validates schema' do
        expect(response).to match_response_schema('product/index')
      end

      it 'validates response' do
        expect(response.status).to eq(200)
        JSON.parse(response.body).tap do |json|
          expect(json['records'][0]['id']).to eq(product.id)
        end
      end
    end

    context 'without shop_id' do
      before do
        get :index
      end

      it 'should response fail' do
        expect(response.status).to eq(400)
      end
    end
  end

  describe '#show' do
    before do
      get :show, params: {
        id: product.id
      }
    end

    it 'validates schema' do
      expect(response).to match_response_schema('product/product')
    end

    it 'validates response' do
      JSON.parse(response.body).tap do |json|
        expect(json['id']).to eq(product.id)
      end
    end
  end
end
