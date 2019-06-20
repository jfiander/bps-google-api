# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'bps-google-api'
  s.version       = '0.1.5'
  s.date          = '2019-06-15'
  s.summary       = 'Configured Google API'
  s.description   = 'A configured Google API wrapper.'
  s.homepage      = 'http://rubygems.org/gems/bps-google-api'
  s.license       = 'GPL-3.0'
  s.authors       = ['Julian Fiander']
  s.email         = 'julian@fiander.one'
  s.require_paths = %w[lib]
  s.files         = `git ls-files`.split("\n")

  s.required_ruby_version = '~> 2.4'

  s.add_runtime_dependency 'exp_retry',         '~> 0.0.11'
  s.add_runtime_dependency 'fileutils',         '~> 1.2'
  s.add_runtime_dependency 'google-api-client', '~> 0.23.4'
  s.add_runtime_dependency 'ruby-progressbar',  '~> 1.10'
end
