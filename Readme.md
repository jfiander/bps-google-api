# BPS Google API

A configured Google API wrapper.

## Installation

Add this to your Gemfile:

```ruby
gem 'bps-google-api'
```

or install directly:

```bash
gem install bps-google-api
```

Then run the following in `config/application.rb`:

```ruby
require 'google_api'
```

## Required Environment

```bash
GOOGLE_CLIENT_ID
GOOGLE_CLIENT_SECRET

GOOGLE_ACCESS_TOKEN
GOOGLE_REFRESH_TOKEN
GOOGLE_AUTH_EXP

GOOGLE_AUTH_SCOPE_CALENDAR
GOOGLE_AUTH_SCOPE_GROUP

GOOGLE_CALENDAR_ID_GEN
GOOGLE_CALENDAR_ID_EDUC
GOOGLE_CALENDAR_ID_TEST
```

## Usage

```ruby
calendar = GoogleAPI::Calendar.new

calendar.create(cal_id, event_options)
calendar.list(cal_id, max_results: 2500, page_token: nil)
calendar.get(cal_id, event_id)
calendar.update(cal_id, event_id, event_options)
calendar.delete(cal_id, event_id)

calendar.permit(calendar, user)
calendar.unpermit(calendar, user)
```

```ruby
group = GoogleAPI::Group.new('group@example.com')

group.get
group.members
group.add('somebody@example.com')
group.remove('somebody@example.com')
```
