require 'semantic_puppet'

module Convoke
  class Dependency
    attr_reader :version_range

    def initialize(name, version_range)
      @name = name
      @version_range = SemanticPuppet::VersionRange.parse(version_range)
    end

    def name
      @name.gsub('/', '-')
    end
  end
end
