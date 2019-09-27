# frozen_string_literal: true

require 'spec_helper'
require 'convoke/resolver'

RSpec.describe Convoke::Resolver do
  let(:simple_module_dir) { File.expand_path('spec/fixtures/simple') }
  let(:resolver) { Convoke::Resolver.new(pwd: simple_module_dir) }

  describe 'resolve' do
    subject { resolver.resolve }

    it { is_expected.not_to be_empty }
  end
end
