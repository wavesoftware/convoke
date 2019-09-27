require 'json'
require 'convoke/module'
require 'convoke/dependency'

module Convoke
  class Metadata
    def initialize(pwd, filename)
      @path = Pathname.new(pwd).join(filename)
      @metadata = nil
      raise "Puppet metadata can't be found at: #{@path}" unless @path.file?
    end

    def module
      Convoke::Module.new(metadata['name'], metadata['version'])
    end

    def dependencies
      metadata['dependencies'].map do |entry|
        Convoke::Dependency.new(entry['name'], entry['version_requirement'])
      end
    end

    private

    def metadata
      return @metadata unless @metadata.nil?
      begin
        contents = @path.read
      rescue Exception => e
        abort("Error: Unable to read metadata file: #{e.exception}")
      end
  
      begin
        @metadata = JSON.parse(contents)
      rescue Exception => e
        abort("Error: Unable to parse metadata.json: #{e.exception}")
      end
    end
  end
end
