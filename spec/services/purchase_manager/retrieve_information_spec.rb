# frozen_string_literal: true

require 'rails_helper'

describe PurchaseManager::RetrieveInformation, type: :model do
  let(:token) { 'BDCxQxsKSZ8' }
  let(:success_response) { File.read("#{Rails.root}/spec/fixtures/purchase_manager/success_retrieve_information.json") }

  context 'with a purchase complete' do
    it 'return status completed' do
      stub_request(:get, "#{ENV['PURCHASE_API_URL']}/api/v2/purchases/#{token}")
        .to_return(body: success_response, status: 200)
      response = described_class.call(token)
      expect(response.fetch('purchase').fetch('state')).to eq('completed')
      expect(response.fetch('purchase').fetch('token')).to eq(token)
    end
  end

  context 'purchase not found' do
    it 'return nil' do
      stub_request(:get, "#{ENV['PURCHASE_API_URL']}/api/v2/purchases/#{token}")
        .to_return(body: '', status: 404)
      response = described_class.call(token)
      expect(response).to be_nil
    end
  end
end
