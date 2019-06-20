# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GoogleAPI::Group do
  describe 'service class' do
    subject { described_class.new }

    it 'has a service class' do
      expect { subject.send(:service_class) }.not_to raise_error
    end

    it 'has the correct service class' do
      expect(subject.send(:service_class)).to eql(Google::Apis::AdminDirectoryV1::DirectoryService)
    end
  end

  context 'with an invalid group' do
    subject { GoogleAPI::Configured::Group.new('test-group@example.com') }

    describe 'get' do
      it 'returns not found for a nonexistent group' do
        expect { subject.get }.to raise_error(
          Google::Apis::ClientError, 'forbidden: Not Authorized to access this resource/api'
        )
      end
    end

    describe 'members' do
      it 'returns forbidden for a nonexistent group' do
        expect { subject.members }.to raise_error(
          Google::Apis::ClientError, 'forbidden: Not Authorized to access this resource/api'
        )
      end
    end

    describe 'add' do
      it 'returns not found for a nonexistent group' do
        expect(subject.add('test-member@example.com')).to eql(:already_exists)
      end
    end

    describe 'remove' do
      it 'returns not found for a nonexistent group' do
        expect(subject.remove('test-member@example.com')).to eql(:not_found)
      end
    end
  end
end
