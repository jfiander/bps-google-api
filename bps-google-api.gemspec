Gem::Specification.new do |s|
  s.name          = 'bps-google-api'
  s.version       = '0.0.2'
  s.date          = '2019-04-11'
  s.summary       = 'Configured Google API'
  s.description   = 'A configured Google API wrapper.'
  s.homepage      = 'http://rubygems.org/gems/bps-google-api'
  s.license       = 'GPL-3.0'
  s.authors       = ['Julian Fiander']
  s.email         = 'julian@fiander.one'
  s.require_paths = %w[lib]
  s.files         = `git ls-files`.split("\n")

  s.add_runtime_dependency 'google-api-client', '~> 0.23.4'
  s.add_runtime_dependency 'exp_retry'
  s.add_runtime_dependency 'ruby-progressbar'
end
