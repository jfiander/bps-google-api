# frozen_string_literal: true

class GoogleAPI
  module Configured
    class Calendar
      class Event
        def self.api
          @api ||= GoogleAPI::Calendar.new
        end

        attr_reader :calendar_id, :event_id

        def initialize(calendar_id, event_id)
          @calendar_id = calendar_id
          @event_id = event_id
        end

        def get
          self.class.api.get(calendar_id, event_id)
        end

        def patch(patch_options = {})
          self.class.api.patch(calendar_id, event_id, patch_options)
        end

        def update(event_options = {})
          self.class.api.update(calendar_id, event_id, event_options)
        end

        def delete
          self.class.api.delete(calendar_id, event_id)
        end

        def add_conference
          self.class.api.add_conference(calendar_id, event_id)
        end

        def conference_info(all: false)
          self.class.api.conference_info(calendar_id, event_id, all: all)
        end
      end
    end
  end
end
