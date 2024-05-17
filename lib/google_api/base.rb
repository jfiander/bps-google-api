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

    def call(...)
      if GoogleAPI.mock
        mock(...)
      else
        ExpRetry.for(exception: RETRIES) { service.send(...) }
      end
    end

    # :nocov:
    def mock(*)
      raise 'This method must be overwritten by the inheriting class.'
    end
    # :nocov:
  end
end
