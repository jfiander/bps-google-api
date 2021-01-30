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
end
