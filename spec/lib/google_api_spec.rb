# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GoogleAPI do
  it 'sets the log level correctly' do
    expect { GoogleAPI.logging!(:FATAL) }.to(
      change(Google::Apis.logger, :level).from(Logger::WARN).to(Logger::FATAL)
    )
  end

  it 'raises for invalid levels' do
    expect { GoogleAPI.logging!(:WRONG) }.to raise_error(ArgumentError, 'Unknown level')
  end

  it 'sets the mock flag' do
    expect { GoogleAPI.mock! }.to change { GoogleAPI.mock }.from(false).to(true)
  end
end
