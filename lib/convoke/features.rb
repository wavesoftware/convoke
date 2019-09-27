module Convoke
  def self.features
    @features = Convoke::Features.new if @features.nil?
    @features
  end

  class Features
    def initialize
      @list = {}
    end

    def syslog?
      resolve :syslog do
        lib? 'syslog'
      end
    end

    def posix?
      resolve :posix do
        require 'etc'
        require 'rbconfig'
        Convoke.features.syslog? &&
          (RbConfig::CONFIG['host_os'] =~ /cygwin/ || !Etc.getpwuid(0).nil?)
      end
    end

    private

    def resolve(name, &block)
      @list[name] = !(!(block.call)) if @list[name].nil?
      @list[name]
    end

    def lib?(lib, name = nil)
      name = lib if name.nil?
      require lib
      true
    rescue LoadError
      # Expected case. Required library insn't installed.
      Convoke.logger.debug("Could not find library '%{lib}' required to enable feature '%{name}'" %
        {lib: lib, name: name})
      false
    rescue StandardError, ScriptError => detail
      Convoke.logger.debug("Exception occurred while loading library '%{lib}' required to enable feature '%{name}': %{detail}" %
        {lib: lib, name: name, detail: detail})
      false
    end
  end
end
