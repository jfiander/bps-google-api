# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'bps-google-api'
  s.version       = '0.4.12'
  s.date          = '2023-03-13'
  s.summary       = 'Configured Google API'
  s.description   = 'A configured Google API wrapper.'
  s.homepage      = 'http://rubygems.org/gems/bps-google-api'
  s.license       = 'GPL-3.0'
  s.authors       = ['Julian Fiander']
  s.email         = 'julian@fiander.one'
  s.require_paths = %w[lib]
  s.files         = `git ls-files`.split("\n")

  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'exp_retry',         '~> 0.0.13'
  s.add_runtime_dependency 'fileutils',         '~> 1.2'
  s.add_runtime_dependency 'google-api-client', '~> 0.23.4'
  s.add_runtime_dependency 'ruby-progressbar',  '~> 1.10'

  s.add_development_dependency 'rspec',     '~> 3.8',  '>= 3.8.0'
  s.add_development_dependency 'rubocop',   '~> 0.71', '>= 0.71.0'
  s.add_development_dependency 'simplecov', '~> 0.16', '>= 0.16.1'
end
