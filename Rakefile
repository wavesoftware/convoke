# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

# i18n/gettext Rake tasks
spec = Gem::Specification.find_by_name 'gettext-setup'
load "#{spec.gem_dir}/lib/tasks/gettext.rake"
GettextSetup.initialize(File.absolute_path('locales', File.dirname(__FILE__)))

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names']
end

desc 'Runs code linters'
task lint: [:rubocop]

desc 'Run RSpec unit tests'
RSpec::Core::RakeTask.new(:'spec:unit')

desc 'Run RSpec unit & integration tests'
task spec: [:'spec:unit']

desc 'Run all checks and tests'
task check: %i[lint spec]
