# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GoogleAPI::Base do
  subject { described_class.new }

  it 'does not have a service class' do
    expect { subject }.to raise_error(
      NameError, 'uninitialized constant GoogleAPI::Base::SERVICE_CLASS'
    )
  end
end
