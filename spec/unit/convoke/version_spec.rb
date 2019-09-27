# frozen_string_literal: true

require 'spec_helper'
require 'matchers/semver'

RSpec.describe Convoke do
  describe '.VERSION' do
    let(:value) { Convoke::VERSION }
    # Convert to Semantic Puppet style version from Ruby accepted style
    subject { value.gsub('.pre', '-pre') }

    it { is_expected.to be_semanticlly_correct }
  end
end
