module Paymaya
  class Client
    include ClassSupportMixin
    include Paymaya::Configuration
  
    set_attributes :host => 'pg-sandbox.paymaya.com',
      :port => '443',
      :version => 'v1',
      :secret => '',
      :api => '',
      :payment_token_id => '',
      :currency => 'PHP'
    
    attr_reader :version, :secret, :payment_token_id
    
    def payment_tokens(card)
      request = send_request("#{setup_api_host}/payment-tokens", card)
      response = get_response(request)
      self
    end

    def payments(amount, buyer)
      buyer = JSON.parse(buyer)
      unless self.payment_token_id.nil?
        payload = {
          paymentTokenId: self.payment_token_id,
          totalAmount: {
            amount: amount,
            currency: self.currency
          },
          buyer: buyer
        }.to_json

        request = send_request("#{setup_api_host}/payments", payload)
        response = get_response(request)
        puts "Response: #{response.body}"
      else
        raise "Payment Token not Found"
      end
    end
    
    private

      def setup_api_host
        "https://#{self.host}/payments/#{self.version}"
      end
          
      def send_request(url, args)
        uri = URI.parse(url)
        
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = true

        request = Net::HTTP::Post.new(uri.request_uri)

        request.set_content_type("application/json")
        request.basic_auth(self.secret, '')
        request.body = args

        request
      end
      
      def get_response(request)
        response = @http.request(request)
        
        if response.body and !response.body.empty?
          object = JSON.parse(response.body)
          if object["state"] == "AVAILABLE"
            self.payment_token_id = object["paymentTokenId"] # unless object["paymentTokenId"].nil?
          end
        end

        if response.kind_of? Net::HTTPClientError
          error = Paymaya::Response.new object["code"]
          raise error.to_s
        end

        response
      end
  end
end
