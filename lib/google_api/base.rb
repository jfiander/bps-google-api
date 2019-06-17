# frozen_string_literal: true

module GoogleAPI
  require 'google_api/base/authorization'

  class Base
    RETRIES ||= [
      Google::Apis::TransmissionError, Google::Apis::ServerError,
      Google::Apis::RateLimitError, Errno::ECONNRESET
    ].freeze

    include GoogleAPI::Base::Authorization

    def initialize(auth: true)
      authorize! if auth
    end

  private

    def service_class
      self.class::SERVICE_CLASS
    end

    def service
      raise 'No service class defined.' unless defined?(service_class)

      @service ||= service_class.new
    end

    def call(method, *args)
      ExpRetry.for(exception: RETRIES) { service.send(method, *args) }
    end

    def root_path
      defined?(Rails) ? Rails.root : '.'
    end

    def last_token_path
      path = %w[tmp run last_page_token]
      File.join(root_path, *path)
    end
  end
end
