Wordnik.configure do |config|
  config.api_key = '748296f33dda75ee9816d023c8a0f773acccf08a45093647a'
  config.username = 'negomi'
  config.password = 'sg2ldDl4Fqzn'
  config.response_format = 'json'
  config.logger = Logger.new('/dev/null') # defaults to Rails.logger or Logger.new(STDOUT). Set to Logger.new('/dev/null') to disable logging.
end
