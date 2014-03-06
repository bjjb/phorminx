require 'pathname'

module Phorminx
  autoload :VERSION,    'phorminx/version'
  autoload :Logging,    'phorminx/logging'
  autoload :CLI,        'phorminx/cli'
  autoload :Rails,      'phorminx/rails'
  autoload :Loader,     'phorminx/loader'
  autoload :Inspector,  'phorminx/inspector'
  autoload :Formatter,  'phorminx/formatter'
  autoload :Runner,     'phorminx/runner'

  include Logging
  include Rails   # app detection

  def self.loader
    Loader.new
  end

  def self.inspector
    Inspector.new
  end

  def self.formatter
    @formatter ||= Formatter::JSON.new
  end

  def self.formatter=(f)
    @formatter = case f
      when Formatter then f
      when symbol    then Formatter.load(f)
      when Proc      then Class.new(Formatter, &f)
      else           raise Formatter::Unknown, f.to_s
    end
  end

  def self.runner
    Runner.new(loader, inspector, formatter)
  end
end
