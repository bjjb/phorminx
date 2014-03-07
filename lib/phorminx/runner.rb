module Phorminx
  class Runner
    def initialize(loader, analyser, formatter)
      @loader, @analyser, @formatter = loader, analyser, formatter
    end

    def run
      @formatter.format(@analyser.analyse(@loader.load))
    end
  end
end
