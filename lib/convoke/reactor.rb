require 'semantic_puppet'

module Convoke
  class Reactor
    def initialize
      @core = {}
    end

    def needed?(dep)
      @core[dep.name].nil?
    end

    def add(dep, mod)
      @core[dep.name] = Candidate.new(dep, mod)
      1
    end

    def convoke
      candidates = @core.values
        .map { |candidate| candidate.releases }
      candidates
    end    
  end

  private

  class Candidate
    attr_reader :dep, :mod
    def initialize(dep, mod)
      @dep = dep
      @mod = mod
    end

    def releases
      @mod.releases.select do |release|
        ver = SemanticPuppet::Version.parse(release.version)
        @dep.version_range.include?(ver)
      end
    end
  end
end
