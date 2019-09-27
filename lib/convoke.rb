# frozen_string_literal: true

require 'logger'

# A Convoke main module
module Convoke
  @logger = Logger.new(STDOUT)

  def self.logger
    @logger
  end
end

require 'convoke/version'
require 'convoke/features'
