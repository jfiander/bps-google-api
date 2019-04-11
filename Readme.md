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
```

```ruby
group = GoogleAPI::Group.new('group@example.com')
```
