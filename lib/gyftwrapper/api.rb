require 'digest'
require 'rest-client'
require "ostruct"
require "pathname"
require "yaml"
require "erb"
require 'resultable'

module Gyftwrapper
  class API
    include Resultable

    CALLS = {
      purchase_card: '/reseller/purchase/card'
    }

    attr_accessor :result, :config

    def initialize
      self.result = Result.new
      self.config = parse_config_file
    end

    def purchase_card(params)
      send_request do
        RestClient.post(url_for(:purchase_card), params, 'x-sig-timestamp' => timestamp)
      end
    end

    private

    def send_request
      return result unless config

      begin
        result.response = OpenStruct.new(JSON.parse(yield))
        result.successful!
      rescue => e
        result.response = e.response
      end

      result
    end

    def url_for(call_type)
      "#{config.endpoint}#{CALLS[call_type]}?api_key=#{config.api_key}&sig=#{signature}"
    end

    def timestamp
      Time.now.getutc.to_i.to_s
    end

    def signature
      signature_string = config.api_key + config.api_secret + timestamp
      Digest::SHA256.new.hexdigest(signature_string)
    end

    def parse_config_file
      file = Rails.root.join("config").join("gyftwrapper.yml")
      data = YAML.load(ERB.new(IO.read(file)).result)[Rails.env] rescue nil

      result.response = 'Provide configs in gyftwrapper.yml file' unless data

      data ? OpenStruct.new(data) : data
    end
  end
end
