# frozen_string_literal: true

module GoogleAPI
  module Configured
    class Calendar
      CALENDAR_API ||= GoogleAPI::Calendar.new

      attr_reader :calendar_id

      def initialize(calendar_id)
        @calendar_id = calendar_id
      end

      def list(max_results: 2500, page_token: nil)
        CALENDAR_API.list(calendar_id, max_results: max_results, page_token: page_token)
      end

      def create(event_options = {})
        CALENDAR_API.create(calendar_id, event_options)
      end

      def get(event_id)
        CALENDAR_API.get(calendar_id, event_id)
      end

      def update(event_id, event_options = {})
        CALENDAR_API.update(calendar_id, event_id, event_options)
      end

      def delete(event_id)
        CALENDAR_API.delete(calendar_id, event_id)
      end

      def permit(user = nil, email: nil)
        CALENDAR_API.permit(calendar_id, user, email: email)
      end

      def unpermit(user = nil, calendar_rule_id: nil)
        CALENDAR_API.unpermit(calendar_id, user, calendar_rule_id: calendar_rule_id)
      end

      def clear_test_calendar(page_token: nil, page_limit: 50, verbose: false, error: false)
        CALENDAR_API.clear_test_calendar(
          page_token: page_token, page_limit: page_limit, verbose: verbose, error: error
        )
      end
    end
  end
end
