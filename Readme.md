# BPS Google API

[![Gem Version](https://img.shields.io/gem/v/bps-google-api.svg)](https://rubygems.org/gems/bps-google-api)
[![Build Status](https://travis-ci.org/jfiander/bps-google-api.svg)](https://travis-ci.org/jfiander/bps-google-api)

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

Configure the root directories for the gem:

```ruby
GoogleAPI.configure do |config|
  config.root = File.join('tmp', 'google_api')
end
```

For Rails, create an initializer:

```ruby
GoogleAPI.configure do |config|
  config.root = Rails.root.join('config', 'google_api')
  config.keys = Rails.root.join('config', 'keys')
end
```

Then add the following in `config/application.rb`:

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

GOOGLE_CALENDAR_ID_TEST

TZ # Timezone
```

## Usage

By default, if no configuration is available, `.new` will automatically run
`.authorize!` and return a URL to generate an authorization token.

### Configured Classes

There are configured classes for both calendars and groups. This allows you to
only specify the parent id once.

```ruby
calendar = GoogleAPI::Configured::Calendar.new(calendar_id)

calendar.create(event_options)
calendar.list(max_results: 2500, page_token: nil)
calendar.list_all
calendar.get(event_id)
calendar.patch(event_id, patch_options)
calendar.update(event_id, updated_event_options)
calendar.add_conference(event_id)
calendar.conference_info(event_id, all: false)
calendar.delete(event_id)

calendar.permit(user)
calendar.unpermit(user)
```

```ruby
group = GoogleAPI::Configured::Group.new('group@example.com')

group.get
group.members
group.add('somebody@example.com')
group.remove('somebody@example.com')
```

There is also an event-specific configured class:

```ruby
event = GoogleAPI::Configured::Calendar::Event.new(calendar_id, event_id)

event.get
event.patch(patch_options)
event.update(updated_event_options)
event.add_conference
event.conference_info(all: false)
event.delete
```

### Event Options

Available event options are listed in `GoogleAPI::Calendar::VALID_EVENT_KEYS`.

```ruby
repeat_pattern = 'WEEKLY' # 'DAILY', etc.
recurrence = ["RRULE:FREQ=#{repeat_pattern};COUNT=#{sessions}"]

event_options = {
  start: start_date, end: end_date, recurrence: recurrence,
  summary: event_title, description: event_description,
  location: location
}
```

To add a Meet call to an event, merge the following into `event_options`:

```ruby
{ conference: { id: meeting_id, signature: meeting_signature } }
```

To create a new Meet call on an event, merge the following into
`event_options` instead:

```ruby
{ conference: { id: :new } }
```

## Testing

### Rspec

Rspec testing is available:

`bundle exec rspec`

The spec suite will fail if under 100% coverage.

### Rubocop

Rubocop formatting validation is available:

`bundle exec rubocop`

### Automatic Builds

Builds are generated automatically by [Travis CI](https://travis-ci.org/jfiander/bps-google-api).

Build success requires both `rspec` and `rubocop` to pass.
