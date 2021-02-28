# frozen_string_literal: true

require 'google_api/base/authorization'

class GoogleAPI
  class Base
    include GoogleAPI::Base::Authorization

    RETRIES ||= [
      Google::Apis::TransmissionError, Google::Apis::ServerError,
      Google::Apis::RateLimitError, Errno::ECONNRESET
    ].freeze

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
      if GoogleAPI.mock
        send(:mock, method, *args)
      else
        ExpRetry.for(exception: RETRIES) { service.send(method, *args) }
      end
    end
  end
end
