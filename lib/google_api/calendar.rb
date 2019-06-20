# frozen_string_literal: true

module GoogleAPI
  class Calendar < GoogleAPI::Base
    def self.last_token_path
      FileUtils.mkdir_p(File.join(GoogleAPI::Base.root_path, 'tmp', 'run'))
      File.join(GoogleAPI::Base.root_path, 'tmp', 'run', 'last_page_token')
    end

    require 'google_api/calendar/clear_test_calendar'
    include GoogleAPI::Calendar::ClearTestCalendar

    SERVICE_CLASS = Google::Apis::CalendarV3::CalendarService
    VALID_EVENT_KEYS ||= %i[
      summary start end description location recurrence conference_data conference_data_version
    ].freeze

    def create(calendar_id, event_options = {})
      call(:insert_event, calendar_id, event(event_options), conference_data_version: 1)
    end

    def list(calendar_id, max_results: 2500, page_token: nil)
      call(:list_events, calendar_id, max_results: max_results, page_token: page_token)
    end

    def get(calendar_id, event_id)
      call(:get_event, calendar_id, event_id)
    end

    def update(calendar_id, event_id, event_options = {})
      call(:update_event, calendar_id, event_id, event(event_options))
    end

    def delete(calendar_id, event_id)
      call(:delete_event, calendar_id, event_id)
    rescue Google::Apis::ClientError
      :event_not_found
    end

    def permit(calendar, user = nil, email: nil)
      email ||= user&.email

      rule = Google::Apis::CalendarV3::AclRule.new(
        scope: { type: 'user', value: email }, role: 'writer'
      )

      user&.update(calendar_rule_id: call(:insert_acl, calendar, rule).id)
    end

    def unpermit(calendar, user = nil, calendar_rule_id: nil)
      calendar_rule_id ||= user&.calendar_rule_id

      call(:delete_acl, calendar, calendar_rule_id)
    rescue Google::Apis::ClientError
      :permission_not_found
    ensure
      user&.update(calendar_rule_id: nil)
    end

  private

    def event(event_options)
      event_options.assert_valid_keys(VALID_EVENT_KEYS)
      event_options[:start] = date(event_options[:start])
      event_options[:end] = date(event_options[:end])

      Google::Apis::CalendarV3::Event.new(event_options.reject { |_, v| v.nil? })
    end

    def date(date)
      key = date&.is_a?(String) ? :date : :date_time
      Google::Apis::CalendarV3::EventDateTime.new(key => date, time_zone: ENV['TZ'])
    end
  end
end
