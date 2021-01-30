# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup
require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
  add_filter '/lib/ext'
end
SimpleCov.minimum_coverage(100)

require 'google_api'

def silently
  original_stdout = $stdout
  $stdout = File.new(GoogleAPI.configuration.local_path('null'), 'w')
  yield
  $stdout = original_stdout
end

RSpec.configure do |config|
  config.before(:suite) do
    GoogleAPI.configure do |c|
      c.root = 'tmp/spec'
      c.keys = 'tmp/spec/keys'
    end

    GoogleAPI.logging!(:INFO)

    FileUtils.rm(Dir.glob(GoogleAPI.configuration.local_path('*', &:keys)))

    ENV['GOOGLE_AUTHORIZATION_CODE'] = 'test-auth-code'
    ENV['HIDE_PROGRESS_BARS'] = 'true'
  end
end
