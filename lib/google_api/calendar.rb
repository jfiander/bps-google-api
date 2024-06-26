# frozen_string_literal: true

require 'google_api/calendar/conference'
require 'google_api/calendar/clear_test_calendar'

class GoogleAPI
  class Calendar < GoogleAPI::Base
    include GoogleAPI::Calendar::Conference
    include GoogleAPI::Calendar::ClearTestCalendar

    SERVICE_CLASS = Google::Apis::CalendarV3::CalendarService
    VALID_EVENT_KEYS ||= %i[
      summary start end description location recurrence conference conference_data
    ].freeze
    VALID_PATCH_KEYS ||= %i[
      summary start end description location recurrence conference_data created reminders creator
      etag html_link i_cal_uid id kind organizer reminders sequence status updated
    ].freeze

    def self.last_token_path
      GoogleAPI.configuration.local_path('tmp', 'run', 'last_page_token')
    end

    def create(calendar_id, **event_options)
      call(:insert_event, calendar_id, event(false, **event_options), conference_data_version: 1)
    end

    def list(calendar_id, max_results: 2500, page_token: nil)
      call(:list_events, calendar_id, max_results: max_results, page_token: page_token)
    end

    def list_all(calendar_id, verbose: false)
      events = []

      l = call(:list_events, calendar_id)
      events += l.items

      while (page_token = l.next_page_token)
        l = call(:list_events, calendar_id, page_token: page_token)
        page_token = l.next_page_token
        events += l.items
        print('.') if verbose
      end

      events
    end

    def get(calendar_id, event_id)
      call(:get_event, calendar_id, event_id)
    end

    def patch(calendar_id, event_id, **patch_options)
      call(:patch_event, calendar_id, event_id, patch_options, conference_data_version: 1)
    end

    def update(calendar_id, event_id, **event_options)
      call(:update_event, calendar_id, event_id, event(**event_options), conference_data_version: 1)
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

    def event(patch = false, **event_options)
      validate_keys(patch, **event_options)

      event_options = format_dates(**event_options)
      event_options = format_conference_data(**event_options)

      Google::Apis::CalendarV3::Event.new(**event_options.reject { |_, v| v.nil? })
    end

    def validate_keys(patch = false, **event_options)
      event_options.assert_valid_keys(VALID_EVENT_KEYS) unless patch
      event_options.assert_valid_keys(VALID_PATCH_KEYS) if patch
    end

    def format_dates(**event_options)
      event_options[:start] = format_date(event_options[:start])
      event_options[:end] = format_date(event_options[:end])
      event_options
    end

    def format_date(date)
      return date if date.is_a?(Google::Apis::CalendarV3::EventDateTime)

      key = date.is_a?(String) ? :date : :date_time
      Google::Apis::CalendarV3::EventDateTime.new(key => date, time_zone: ENV['TZ'])
    end

    def mock(*)
      Google::Apis::CalendarV3::Event.new(
        id: SecureRandom.hex(8),
        html_link: 'http://calendar.google.com',
        conference_id: 'abc-defg-hjk'
      )
    end
  end
end
