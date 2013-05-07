require "active_record"
require 'pathname'
require 'erb'
require 'yaml'

module Phorminx
  class ActiveRecordInspector
    # The root of the Rails app
    attr_accessor :root
    # Namespace given to Phorminx models
    attr_accessor :namespace
    # Locations for existing model definitions (absolute)
    attr_accessor :model_dirs
    # Environment (for choosing DB connection, if needed)
    attr_accessor :env

    def initialize(options = {})
      @namespace = options[:namespace] || self.class.namespace

      @root = Pathname.new(options[:root] || '.').expand_path
      
      @model_dirs = []
      options[:model_dirs].each { |d| @model_dirs.push(@root.join(d)) } if options[:model_dirs]
      @model_dirs.push(@root.join('app/models')) if @model_dirs.empty?

      @env = (options[:env] || :development).to_s

      self.db = options[:db] if options[:db]
    end

    def db=(config)
      if config.is_a?(String) and @root.join(config).exist?
        config = YAML.load(ERB.new(@root.join(config).read).result) 
      end
      @db = config.key?(@env) ? config[@env] : @db
    end

    def db
      @db ||= { 'adapter' => 'sqlite3', 'database' => ':memory:' }
    end

    def tables
      connection.tables
    end

    def connected?
      ActiveRecord::Base.connected?
    end

    def connect!
      ActiveRecord::Base.establish_connection(db)
    end

    def connection
      connect! unless connected?
      ActiveRecord::Base.connection
    end

    class << self
      def namespace=(namespace)
        @@namespace = namespace
      end

      def namespace
        @@namespace ||= name
      end
    end
  end
end
