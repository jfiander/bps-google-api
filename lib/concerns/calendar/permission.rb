# frozen_string_literal: true

module GoogleAPI::Concerns::Calendar
  module Permission
    def permit(calendar, user)
      rule = Google::Apis::CalendarV3::AclRule.new(
        scope: { type: 'user', value: user.email }, role: 'writer'
      )

      result = service.insert_acl(calendar, rule)
      user.update(calendar_rule_id: result.id)
    end

    def unpermit(calendar, user)
      service.delete_acl(calendar, user&.calendar_rule_id)
    rescue Google::Apis::ClientError
      :permission_not_found
    ensure
      user.update(calendar_rule_id: nil)
    end
  end
end
