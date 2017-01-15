lib = File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'paymaya-rails'
  gem.version     = '0.0.1'
  gem.date        = '2016-08-19'
  gem.summary     = "Paymaya Rails"
  gem.description = "A rails gem for payama api"
  gem.authors     = ["Ian Bert Tusil"]
  gem.email       = 'ian@codigu.co'
  gem.files       = ["lib/paymaya.rb"]
  gem.homepage    =
    'http://rubygems.org/gems/paymaya-rails'

  gem.license       = 'MIT'
  gem.require_paths = %w[lib]

  gem.add_dependency('multi_json', '~> 1.0')
end