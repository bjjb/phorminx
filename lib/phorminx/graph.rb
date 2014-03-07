require 'phorminx'
require 'set'

module Phorminx
  # A class made up of Nodes with links between them. To link a node to
  # others, call link.
  class Graph
    autoload :Node, 'phorminx/graph/node'
    autoload :Link, 'phorminx/graph/link'

    attr_reader :nodes, :links

    def initialize(nodes = [])
      @nodes, @links = Set.new(nodes), Set.new
    end

    def self.build(things, &resolver)
      graph = new(things)
    end

    def resolve!(&block)
      @nodes.each do |left|
        @nodes.each do |right|
          link!(left, right, link) if link = yield(left, right)
        end
      end
    end

    def link!(left, right, link)
      @links.add(Link.new(left, right, link))
    end

    def each
      @nodes.each { yield [node, links_from(node)] }
    end

    def links_from(node)
      @links.find { |l| l.left == node }
    end

    def links_to(node)
      @links.find { |l| l.right == node }
    end
  end
end
