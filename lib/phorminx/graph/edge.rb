require 'phorminx/graph'
require 'delegator'

module Phorminx
  class Graph
    class Edge < Delegator
      attr_accessor :left, :right

      def initialize(object, left, right)
        @object, @left, @right = object, left, right
      end

      def _get_obj_
        @object
      end
    end
  end
end
