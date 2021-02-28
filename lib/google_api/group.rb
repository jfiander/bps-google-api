# frozen_string_literal: true

class GoogleAPI
  class Group < GoogleAPI::Base
    SERVICE_CLASS = Google::Apis::AdminDirectoryV1::DirectoryService

    def initialize(auth: true)
      super(auth: auth)
    end

    def get(group_id)
      call(:get_group, group_id)
    end

    def members(group_id)
      call(:list_members, group_id)
    end

    def add(group_id, email)
      call(:insert_member, group_id, member(email))
    rescue Google::Apis::ClientError
      :already_exists
    end

    def remove(group_id, email)
      call(:delete_member, group_id, email)
    rescue Google::Apis::ClientError
      :not_found
    end

  private

    def member(email)
      Google::Apis::AdminDirectoryV1::Member.new(email: email)
    end

    def mock(*)
      Google::Apis::AdminDirectoryV1::Members.new(
        members: [
          Google::Apis::AdminDirectoryV1::Member.new(email: 'nobody@example.com')
        ]
      )
    end
  end
end
