# frozen_string_literal: true

PROJECT_ROOT = File.join(File.dirname(__FILE__), '..')

unless ENV['COVERAGE'] == 'skip'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'convoke'

