module Paymaya
  class Response
    attr_reader :response_code
    @@error_map = {
      missing_parameter?: 2553,
      database_unavailable?: 1999,
      interal_server_error?: "py0001",
      card_is_expired?: "py0002",
      card_is_invalid?: "py0003",
      card_is_being_processed?: "py0004",
      failed_to_process_card_details?: "py0005",
      payment_is_already_being_processed?: "py0006",
      invalid_token_status?: "py0007",
      token_is_invalid?: "py0008",
      payment_does_not_exist?: "py0009",
      failed_to_process_payment?: "py0010",
      service_timeout?: "py0011",
      service_error?: "py0012",
      card_vault_server_unreachable?: "py0013",
      efs_purchase_server_unreachable?: "py0014",
      efs_purchase_service_unreachable?: "py0015",
      merchant_not_found?: "py0016",
      card_vaule_server_connection_refused?: "py0017",
      forbidden?: "py0018",
      merchant_is_required?: "py0019",
      failed_to_add_customer?: "py0020",
      customer_is_already_being_processed?: "py0021",
      customer_does_not_exist?: "py0022",
      failed_to_delete_customer?: "py0023",
      failed_to_update_customer_details?: "py0024",
      failed_to_update_card_details?: "py0025",
      card_is_already_default?: "py0026",
      card_does_not_exist?: "py0027",
      failed_to_delete_card?: "py0028",
      no_card_found_for_customer?: "py0029",
      invalid_card_token_status?: "py00030",
      card_token_is_invalid?: "py0031",
      failed_to_detokenized_card?: "py0032",
      failed_to_process_webhook?: "py0033",
      webhook_is_already_processed?: "py0034",
      failed_to_add_card_to_customer?: "py00035",
      efs_purchase_service_connection_refused?: "py0042",
    }
    
    @@status_messages = {
      200 => "Success",
      201 => "Updated",
      2553 => "Missing/invalid parameters",
      1999 => "Database error/unavailable",
      "py0001" => "Internal server error",
      "py0002" => "Card is expired",
      "py0003" => "Card is invalid",
      "py0004" => "Card details is being processed",
      "py0005" => "Failed to process card details",
      "py0006" => "Payment is already being processed",
      "py0007" => "Invalid token status",
      "py0008" => "Token is invalid",
      "py0009" => "Payment does not exist",
      "py0010" => "Failed to process payment",
      "py0011" => "Service timeout",
      "py0012" => "Service error",
      "py0013" => "Card Vault server unreachable",
      "py0014" => "Card Vault service error/unavailable",
      "py0015" => "EFS Purchase server unreachable",
      "py0016" => "EFS Purchase service error/unavailable",
      "py0017" => "Merchant not found",
      "py0018" => "Card Vault server connection refused",
      "py0019" => "Forbidden",
      "py0020" => "Merchant is required",
      "py0021" => "Failed to add customer",
      "py0022" => "Customer is already being processed",
      "py0023" => "Customer does not exist",
      "py0024" => "Failed to delete customer",
      "py0025" => "Failed to update customer details",
      "py0026" => "Failed to update card details",
      "py0027" => "Card does not exist",
      "py0028" => "Failed to delete card",
      "py0029" => "No card found for customer",
      "py0030" => "Invalid card token status",
      "py0031" => "Card token is invalid",
      "py0032" => "Failed to detokenized card",
      "py0033" => "Failed to process webhook",
      "py0034" => "Webhook is already processed",
      "py0035" => "Failed to add card to customer",
      "py0042" => "EFS Purchase service connection refused",
    }
    
    def initialize(code)
      @response_code = code
    end
    
    def valid?
      [200, 201].include?(self.response_code)
    end
    
    def to_s
      #"#{self.response_code} - #{msg}"
      msg
    end
    
    def msg(code = self.response_code)
      if msg = @@status_messages[code]
        msg
      else
        raise ArgumentError, "#{code} - undefined response code"
      end
    end
    
    def method_missing(method_id)
      if code = @@error_map[method_id.to_sym]
        self.response_code == code
      else
        raise NoMethodError
      end
    end
  end
end