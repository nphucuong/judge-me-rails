# frozen_string_literal: true

require 'test_helper'

RSpec.describe ShopsController, type: :controller do
  let!(:shop) { create(:shop) }

  describe '#index' do
    before do
      get :index
    end

    it 'validates schema' do
      expect(response).to match_response_schema('shop/index')
    end

    it 'validates response' do
      JSON.parse(response.body).tap do |json|
        expect(json[0]['id']).to eq(shop.id)
      end
    end
  end
end
