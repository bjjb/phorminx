require 'optparse'
require 'ostruct'
require 'phorminx'

module Phorminx
  class CLI < OptionParser
    def initialize
      super
      self.banner = "TODO - all of this shit."
      on("-o", "--output FILE", "output to FILE (rather than STDOUT)", &method(:out))
      on("-C", "--directory DIR", "change directory before running", &method(:cd))
      on("-f", "--format FMT", "choose output format (#{formats.join('|')})", &method(:format))
      on("-h", "--help", "show this message", &method(:help))
      on("-v", "--verbose", "be more noisy", &method(:verbose))
      on("-q", "--quiet", "be less verbose", &method(:quiet))
      on("-V", "--version", "print the version number", &method(:version))
    end
    
    def start!(args)
      order!(args)
      # run!
    end

  private
    def verbose(_)
      Phorminx.logger.level -= 1
    end

    def quiet(_)
      Phorminx.logger.level += 1
    end

    def cd(dir)
      Dir.chdir(dir)
    end

    def out(out)
      Phorminx.out = File.open(out, "w")
    end

    def help(_)
      puts self
      exit 0
    end

    def version(_)
      require 'phorminx/version'
      print "Phorminx v"
      puts Phorminx::VERSION
      exit
    end

    def formats
      []
    end

    def self.start!(args = ARGV)
      new.start!(args)
    end
  end
end
