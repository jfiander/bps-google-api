# frozen_string_literal: true

class GoogleAPI
  module Configured
    class Group
      def self.api
        @api ||= GoogleAPI::Group.new
      end

      attr_reader :group_id

      def initialize(group_id)
        @group_id = group_id
      end

      def get
        self.class.api.get(group_id)
      end

      def members
        self.class.api.members(group_id)
      end

      def add(email)
        self.class.api.add(group_id, email)
      end

      def remove(email)
        self.class.api.remove(group_id, email)
      end
    end
  end
end
