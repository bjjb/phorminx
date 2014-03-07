require 'phorminx/analyser'

module Phorminx
  class Analyser
    # Rails methods for converting models into Nodes, and relations into
    # Links. Mixed into Analysers for which `rails?` returns true.
    module Rails
      def resolve(left, right)
      end
    end
  end
end
