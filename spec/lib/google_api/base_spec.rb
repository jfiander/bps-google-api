# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GoogleAPI::Base do
  subject { described_class.new }

  it 'does not have a service class' do
    expect { subject }.to raise_error(
      NameError, 'uninitialized constant GoogleAPI::Base::SERVICE_CLASS'
    )
  end

  context 'with a valid subclass' do
    subject { GoogleAPI::Calendar }

    it 'returns the correct last token path' do
      expect(GoogleAPI::Calendar::LAST_TOKEN_PATH).to eql('./tmp/run/last_page_token')
    end

    it 'returns an array from authorize with reveal' do
      expect(subject.new(auth: false).authorize!(reveal: true)).to be_a(Array)
    end

    let(:reauth) { proc(subject.new(auth: false).authorize!(refresh: true)) }

    it 'reauthorizes' do
      silently do
        expect { reauth.call }.to raise_error(Signet::AuthorizationError)
      end
    end
  end
end
