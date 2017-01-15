require 'yaml'
require 'json'
require 'minitest/autorun'
# require 'minitest/spec'
# require 'minitest/matchers'

def config_file
  config ||= YAML::load(File.open((File.join(File.dirname(__FILE__), 'config.yml'))))
end

def card_file
  card ||= File.read((File.join(File.dirname(__FILE__), 'card.json')))
end

def payment_file
  card ||= File.read((File.join(File.dirname(__FILE__), 'payment.json')))
end