# frozen_string_literal: true

module PurchaseManager
  # Client to get purchase information
  class RetrieveInformation < ApplicationService
    attr_accessor :purchase_token

    HTTP_OK_CODE = 200

    def initialize(purchase_token)
      @purchase_token = purchase_token
    end

    def call
      response = RestClient.get(purchase_url, {})
      response.code == HTTP_OK_CODE ? JSON.parse(response.body) : nil
    rescue RestClient::ExceptionWithResponse
      nil
    end

    private

    def base_url
      "#{ENV['PURCHASE_API_URL']}/api/v2"
    end

    def purchase_url
      "#{base_url}/purchases/#{purchase_token}"
    end
  end
end
