require 'convoke/metadata'
require 'logger'
require 'rx'
require 'puppet_forge'

module Convoke
  class Resolver
    def initialize(options = {})
      defaults = {
        forge: 'https://forge.puppet.com',
        git: {
          github: { address: 'https://github.com', style: :github }
        },
        pwd: Dir.pwd,
        filename: 'metadata.json',
        cache: { 
          ttl: '30m',
          path: Convoke::default_cache_dir()
        }
      }
      @options = defaults.merge(options)
      @metadata = Convoke::Metadata.new(@options[:pwd], @options[:filename])
      PuppetForge.user_agent = "Convoke/#{Convoke::VERSION}"
      PuppetForge.host = @options[:forge]
    end

    def resolve
      require 'convoke/reactor'
      deps = Rx::Observable.from_array(@metadata.dependencies)
      reactor = Convoke::Reactor.new
      result = nil
      deps
        .map do |dep|
          reactor.add(dep, PuppetForge::Module.find_stateless(dep.name)) if reactor.needed?(dep)
        end
        .reduce { |c1, c2| c1 + c2 }
        .subscribe { |resolved| result = reactor.convoke }
      Convoke.logger.debug("Resolved: #{result.inspect}")
      result
    end
  end

  private

  def self.default_cache_dir
    if Convoke.features.posix?
      ENV['HOME'] + '/.cache/convoke'
    else
      ENV['HOME'] + '/AppData/Local/convoke'
    end
  end
end
