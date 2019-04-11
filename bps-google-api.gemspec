Gem::Specification.new do |s|
  s.name          = 'bps-google-api'
  s.version       = '0.0.1'
  s.date          = '2019-04-11'
  s.summary       = 'Configured Google API'
  s.description   = 'A configured Google API wrapper.'
  s.homepage      = 'http://rubygems.org/gems/bps-google-api'
  s.license       = 'GPL-3.0'
  s.authors       = ['Julian Fiander']
  s.email         = 'julian@fiander.one'
  s.require_paths = %w[lib]
  s.files         = `git ls-files`.split("\n")

  s.runtime_dependency 'google-api-client', '~> 0.23.4'
  s.runtime_dependency 'exp_retry'
  s.runtime_dependency 'ruby-progressbar'
end
