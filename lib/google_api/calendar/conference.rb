# frozen_string_literal: true

class GoogleAPI
  class Calendar < GoogleAPI::Base
    module Conference
      MEET_ICON ||= 'https://lh5.googleusercontent.com/proxy/bWvYBOb7O03a7HK5iKNEAPoUNPEXH1CHZjuOkiqxHx8OtyVn9sZ6Ktl8hfqBNQUUbCDg6T2unnsHx7RSkCyhrKgHcdoosAW8POQJm_ZEvZU9ZfAE7mZIBGr_tDlF8Z_rSzXcjTffVXg3M46v'

      def add_conference(calendar_id, event_id)
        patch_options = {
          conference_data: {
            create_request: { request_id: "#{Time.now.to_i}-#{SecureRandom.hex(16)}" }
          }
        }

        call(:patch_event, calendar_id, event_id, patch_options, conference_data_version: 1)
      end

      def conference_info(calendar_id, event_id = nil, all: false)
        return conference_mock if GoogleAPI.mock

        raise ArgumentError, 'event_id is required' if event_id.nil?

        conf = call(:get_event, calendar_id, event_id).conference_data
        return conf if all || conf.nil?

        { id: conf.conference_id, signature: conf.signature }
      end

    private

      def format_conference_data(event_options)
        return event_options unless event_options.key?(:conference)

        conference_options = event_options.delete(:conference)
        event_options[:conference_data] = conference_hash(conference_options)
        event_options
      end

      def conference_hash(conference_options)
        if conference_options[:id] == :new
          new_conference
        else
          conference(conference_options[:id], conference_options[:signature])
        end
      end

      def conference(conf_id, signature)
        {
          conference_id: conf_id, conference_solution: meet_solution,
          entry_points: meet_entry(conf_id), signature: signature
        }
      end

      def new_conference
        {
          create_request: {
            request_id: "#{Time.now.to_i}-#{SecureRandom.hex(16)}"
          }
        }
      end

      def meet_solution
        Google::Apis::CalendarV3::ConferenceSolution.new(
          key: Google::Apis::CalendarV3::ConferenceSolutionKey.new(type: 'hangoutsMeet'),
          name: 'Hangouts Meet',
          icon_uri: MEET_ICON
        )
      end

      def meet_entry(conf_id)
        [
          Google::Apis::CalendarV3::EntryPoint.new(
            label: "meet.google.com/#{conf_id}",
            uri: "https://meet.google.com/#{conf_id}",
            entry_point_type: 'video'
          )
        ]
      end

      def conference_mock
        { id: 'abc-defg-hjk', signature: SecureRandom.hex(32) }
      end
    end
  end
end
