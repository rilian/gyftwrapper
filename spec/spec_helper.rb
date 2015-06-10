require 'gyftwrapper'
require 'vcr'
require 'webmock'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into                :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    :match_requests_on => [:method,
      VCR.request_matchers.uri_without_param(:sig)]
  }
end
