require 'logger'

module Phorminx
  module Logging
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end

    def fatal(*args) @logger.fatal(*args) end
    def error(*args) @logger.error(*args) end
    def warn(*args)  @logger.warn(*args)  end
    def info(*args)  @logger.info(*args)  end
    def debug(*args) @logger.debug(*args) end
  end
end
