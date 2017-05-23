# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinterest/version'

Gem::Specification.new do |spec|
  spec.name          = "pinterest-api"
  spec.version       = Pinterest::VERSION
  spec.authors       = ["Adeel Ahmad"]
  spec.email         = ["adeel.rb@gmail.com"]

  spec.summary       = %q{Ruby gem to interact with the Pinterest REST API}
  spec.description   = %q{This gem makes it simple to interact with the official Pinterest REST API}
  spec.homepage      = "http://github.com/realadeel/pinterest-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "dotenv", "~> 2.0"
  spec.add_development_dependency "webmock", "~> 3.0.1"

  spec.add_dependency 'faraday', "~> 0.9"
  spec.add_dependency 'faraday_middleware', "~> 0.9"
  spec.add_dependency 'hashie', "~> 3.0"
  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.0'
end
