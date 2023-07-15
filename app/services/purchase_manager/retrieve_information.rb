# frozen_string_literal: true

module PurchaseManager
  # Client to get purchase information
  class RetrieveInformation < ApplicationService
    attr_accessor :purchase_token

    def initialize(purchase_token)
      @purchase_token = purchase_token
    end

    def call
      response = RestClient.get(url, {})
      response.code == 200 ? JSON.parse(response.body) : nil
    rescue RestClient::ExceptionWithResponse
      nil
    end

    private

    def url
      "#{ENV['PURCHASE_API_URL']}/api/v2/purchases/#{purchase_token}"
    end
  end
end
