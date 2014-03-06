module Phorminx
  class Runner
    include Phorminx
    def initialize(loader, inspector, formatter)
      @loader, @inspector, @formatter = loader, inspector, formatter
    end
  end
end
