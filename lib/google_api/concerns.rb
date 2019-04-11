# frozen_string_literal: true

module GoogleAPI
  module Concerns
    module Base
      require 'google_api/concerns/base/authorization'
    end

    module Calendar
      require 'google_api/concerns/calendar/clear_test_calendar'
      require 'google_api/concerns/calendar/permission'
    end
  end
end
