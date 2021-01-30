# frozen_string_literal: true

class GoogleAPI
  # Core Dependencies
  require 'date'

  # Google Dependencies
  require 'google/apis/calendar_v3'
  require 'google/apis/groupssettings_v1'
  require 'google/apis/admin_directory_v1'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'

  # External dependencies
  require 'exp_retry'
  require 'fileutils'
  require 'ruby-progressbar'

  # Configuration
  require 'google_api/config'

  def self.configuration
    @configuration ||= GoogleAPI::Config.new
  end

  def self.configure
    yield(configuration) if block_given?
    FileUtils.mkdir_p(configuration.root)
    configuration
  end

  def self.logging!(level = :FATAL)
    raise ArgumentError, 'Unknown level' unless %i[DEBUG INFO WARN ERROR FATAL].include?(level)

    Google::Apis.logger.level = Logger.const_get(level)
  end

  # Internal requires
  require 'google_api/base'
  require 'google_api/calendar'
  require 'google_api/group'
  require 'google_api/configured'

  # Extensions
  require 'ext/hash' unless defined?(Rails)
  require 'ext/silent_progress_bar'
end
