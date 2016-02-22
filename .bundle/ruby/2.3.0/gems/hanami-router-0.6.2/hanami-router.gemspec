# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanami/router/version'

Gem::Specification.new do |spec|
  spec.name          = 'hanami-router'
  spec.version       = Hanami::Router::VERSION
  spec.authors       = ['Luca Guidi', 'Trung Lê', 'Alfonso Uceda']
  spec.email         = ['me@lucaguidi.com', 'trung.le@ruby-journal.com', 'uceda73@gmail.com']
  spec.description   = %q{Rack compatible HTTP router for Ruby}
  spec.summary       = %q{Rack compatible HTTP router for Ruby and Hanami}
  spec.homepage      = 'http://hanamirb.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -- lib/* CHANGELOG.md LICENSE.md README.md hanami-router.gemspec`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'http_router',  '~> 0.11'
  spec.add_dependency 'hanami-utils', '~> 0.7'

  spec.add_development_dependency 'bundler',   '~> 1.5'
  spec.add_development_dependency 'minitest',  '~> 5'
  spec.add_development_dependency 'rake',      '~> 10'
  spec.add_development_dependency 'rack-test', '~> 0.6'
end
