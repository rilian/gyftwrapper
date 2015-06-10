require "gyftwrapper/version"
require "gyftwrapper/api"

module Gyftwrapper
  def self.purchase_card(params)
    self.send_request(:purchase_card, params)
  end

  def self.send_request(call_type, params)
    api = Gyftwrapper::API.new
    api.send(call_type, params)
  end
end
