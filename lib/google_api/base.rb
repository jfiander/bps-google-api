# frozen_string_literal: true

class GoogleAPI
  class Base
    RETRIES ||= [
      Google::Apis::TransmissionError, Google::Apis::ServerError,
      Google::Apis::RateLimitError, Errno::ECONNRESET
    ].freeze

    require 'google_api/base/authorization'
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
  end
end
