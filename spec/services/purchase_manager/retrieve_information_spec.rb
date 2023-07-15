# frozen_string_literal: true

require 'rails_helper'

describe PurchaseManager::RetrieveInformation, type: :model do
  let(:token) { 'BDCxQxsKSZ8' }
  let(:success_response) { File.read("#{Rails.root}/spec/fixtures/success_purchase_api_response.json") }

  it 'should be a PurchaseClient' do
    expect(described_class).to eq(PurchaseManager::RetrieveInformation)
  end

  it 'should response with valid information' do
    stub_request(:get, "#{ENV['PURCHASE_API_URL']}/api/v2/purchases/#{token}")
      .to_return(body: success_response, status: 200)
    response = described_class.call(token)
    expect(response.fetch('purchase').fetch('token')).to eq(token)
  end
end
