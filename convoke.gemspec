# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'convoke/version'

Gem::Specification.new do |spec|
  spec.name          = 'convoke'
  spec.version       = Convoke::VERSION
  spec.authors       = ['Wave Software']
  spec.email         = ['info+puppet@wavesoftware.pl']
  spec.summary       = 'A rapid Puppet dependency manager.'
  spec.description   = 'Tool that can be used to rapidly access Puppet Forge '\
                       'published modules and Git repositories to resolve '\
                       'dependencies. It can operate on resolve only mode or '\
                       'also to fetch dependencies to target directory.'
  spec.homepage      = 'https://github.com/wavesoftware/convoke'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'puppet_forge',    '~> 2.3'
  spec.add_dependency 'rx',              '~> 0'
  spec.add_dependency 'semantic_puppet', '~> 1.0'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'

  # Dependencies are pined to support MRI >= 2.1
  spec.add_development_dependency 'bundler',    '~> 1'
  spec.add_development_dependency 'pry-byebug', '~> 3.4.0'
  spec.add_development_dependency 'rake',       '~> 12'
  spec.add_development_dependency 'rubocop',    '~> 0.57.0'
end
