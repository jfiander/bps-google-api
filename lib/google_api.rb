# frozen_string_literal: true

module GoogleAPI
  require 'google/apis/calendar_v3'
  require 'google/apis/groupssettings_v1'
  require 'google/apis/admin_directory_v1'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'

  require 'google_api/base'
  require 'google_api/calendar'
  require 'google_api/group'
end
