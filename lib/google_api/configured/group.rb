# frozen_string_literal: true

module GoogleAPI
  module Configured
    class Group
      GROUP_API ||= GoogleAPI::Group.new

      attr_reader :group_id

      def initialize(group_id)
        @group_id = group_id
      end

      def get
        GROUP_API.get(group_id)
      end

      def members
        GROUP_API.members(group_id)
      end

      def add(email)
        GROUP_API.add(group_id, email)
      end

      def remove(email)
        GROUP_API.remove(group_id, email)
      end
    end
  end
end
