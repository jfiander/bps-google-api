# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GoogleAPI::Calendar do
  subject { described_class.new }

  it 'has a service class' do
    expect { subject.send(:service_class) }.not_to raise_error
  end

  it 'has the correct service class' do
    expect(subject.send(:service_class)).to eql(Google::Apis::CalendarV3::CalendarService)
  end

  describe 'list' do
    it 'returns not found for a nonexistent calendar' do
      expect { subject.list('not-a-calendar') }.to raise_error(
        Google::Apis::ClientError, 'notFound: Not Found'
      )
    end
  end

  describe 'create' do
    it 'returns not found for a nonexistent calendar' do
      expect { subject.create('not-a-calendar') }.to raise_error(
        Google::Apis::ClientError, 'notFound: Not Found'
      )
    end
  end

  describe 'get' do
    it 'returns not found for a nonexistent calendar' do
      expect { subject.get('not-a-calendar', 'not-an-event') }.to raise_error(
        Google::Apis::ClientError, 'notFound: Not Found'
      )
    end
  end

  describe 'update' do
    it 'returns not found for a nonexistent calendar' do
      expect { subject.update('not-a-calendar', 'not-an-event') }.to raise_error(
        Google::Apis::ClientError, 'notFound: Not Found'
      )
    end
  end

  describe 'delete' do
    it 'returns event not found for a nonexistent calendar' do
      expect(subject.delete('not-a-calendar', 'not-an-event')).to eql(
        :event_not_found
      )
    end
  end

  describe 'permit' do
    it 'returns nil for a nonexistent calendar' do
      expect(subject.permit('not-a-calendar', email: 'not-a-user')).to be_nil
    end
  end

  describe 'unpermit' do
    it 'returns permission not found for a nonexistent calendar' do
      expect(subject.unpermit('not-a-calendar', calendar_rule_id: 'not-a-user')).to eql(
        :permission_not_found
      )
    end
  end

  describe 'clear test calendar' do
    it 'does not raise any errors' do
      expect { subject.clear_test_calendar }.not_to raise_error
    end
  end
end
