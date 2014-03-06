require 'pathname'

module Phorminx
  autoload :VERSION, 'phorminx/version'
  autoload :CLI, 'phorminx/cli'
  autoload :Logging, 'phorminx/logging'

  extend Logging

  module Rails
    def rails?
      rails2? or rails3? or rails4?
    end

    def rails2?
      Pathname.new('.').join('config/environment.rb').exist?
    end

    def rails3?
      Pathname.new('.').join('config/application.rb').exist?
    end

    def rails4?
      Pathname.new('.').join('config/application.rb').exist?
    end
  end
  extend Rails
end
