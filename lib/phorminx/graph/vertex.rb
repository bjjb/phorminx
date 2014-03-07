require 'phorminx'
require 'delegator'

module Phorminx
  class Graph
    class Vertex < Delegator
      def initialize(object)
        @object = object
      end

      def _getobj_
        @object
      end
    end
  end
end
