# frozen_string_literal: true

class GoogleAPI
  module Configured
    class Calendar
      def self.api
        @api ||= GoogleAPI::Calendar.new
      end

      attr_reader :calendar_id

      def initialize(calendar_id)
        @calendar_id = calendar_id
      end

      def list(max_results: 2500, page_token: nil)
        self.class.api.list(calendar_id, max_results: max_results, page_token: page_token)
      end

      def create(event_options = {})
        self.class.api.create(calendar_id, event_options)
      end

      def get(event_id)
        self.class.api.get(calendar_id, event_id)
      end

      def patch(event_id, event_options = {})
        self.class.api.patch(calendar_id, event_id, event_options)
      end

      def update(event_id, event_options = {})
        self.class.api.update(calendar_id, event_id, event_options)
      end

      def delete(event_id)
        self.class.api.delete(calendar_id, event_id)
      end

      def permit(user = nil, email: nil)
        self.class.api.permit(calendar_id, user, email: email)
      end

      def unpermit(user = nil, calendar_rule_id: nil)
        self.class.api.unpermit(calendar_id, user, calendar_rule_id: calendar_rule_id)
      end

      def clear_test_calendar(page_token: nil, page_limit: 50, verbose: false, error: false)
        self.class.api.clear_test_calendar(
          page_token: page_token, page_limit: page_limit, verbose: verbose, error: error
        )
      end

      def add_conference(event_id)
        self.class.api.add_conference(calendar_id, event_id)
      end
    end
  end
end
