# frozen_string_literal: true

require 'rspec/expectations'
require 'semantic_puppet'

RSpec::Matchers.define :be_semanticlly_correct do
  match do |actual|
    SemanticPuppet::Version.valid?(actual)
  end
end
