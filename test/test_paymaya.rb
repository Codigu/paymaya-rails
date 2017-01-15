require_relative 'test_helper'
require_relative '../lib/paymaya'

describe Paymaya do

  before do
    @client = initialize_rest_client
  end

  def initialize_rest_client
    Paymaya::Client.connect do |config|
      config.secret = config_file['secret']
    end
  end

  it 'should be able to create payment token' do
    begin
      response = @client.payment_tokens(JSON.parse(card_file).to_json)
    rescue Exception => e
      e.message.must_equal Paymaya::Response.new(200).to_s
    end
  end

  it 'should be able to create payment' do
    begin
      puts @client.payment_token_id
      # response = @client.payments(1000, JSON.parse(payment_file)["buyer"].to_json)
    rescue Exception => e
      e.message.must_equal Paymaya::Response.new(200).to_s
    end
  end
end