require 'json'
module Phorminx
  class Formatter
    class JSON < self
      def format(tree)
        JSON.generate(tree)
      end
    end
  end
end
