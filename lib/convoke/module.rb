require 'semantic_puppet'

module Convoke
  class Module
    attr_reader :version

    def initialize(name, version)
      @name = name
      @version = SemanticPuppet::Version.parse(version)
    end

    def name
      @name.gsub('/', '-')
    end
  end
end
