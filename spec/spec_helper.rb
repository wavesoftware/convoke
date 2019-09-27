# frozen_string_literal: true

PROJECT_ROOT = File.join(File.dirname(__FILE__), '..')

unless ENV['COVERAGE'] == 'skip'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'convoke'
require 'puppet_forge'

RSpec.configure do |config|
  config.before(:example) do
    @old_host = PuppetForge.host
  end

  config.after(:example) do
    PuppetForge.host = @old_host
  end
end
