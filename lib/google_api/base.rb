# frozen_string_literal: true

module GoogleAPI
  class Base
    include GoogleAPI::Concerns::Base::Authorization

    def initialize(auth: false)
      self.authorize! if auth
    end

    def self.root_path
      defined?(Rails) ? Rails.root : './'
    end

  private

    def service
      raise 'No service class defined.' unless defined?(service_class)

      @service ||= service_class.new
    end

    def root_path
      path = self.class.root_path
      FileUtils.mkdir_p(path)
      path
    end
  end
end
