# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup
require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
end

require 'google_api'

RSpec.configure do |config|
  config.before(:suite) do
    FileUtils.mkdir_p('tmp/run')
  end
end
