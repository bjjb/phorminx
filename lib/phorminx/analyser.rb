require 'phorminx'

module Phorminx
  # An Analyser knows how to extract the relationships between models. It has
  # a single method - analyse - which takes an array of models, and returns a
  # Graph representing their relationships.
  #
  # It should behave appropriately depending on the app.
  class Analyser
    include Phorminx

    def initialize
      extend Rails if rails?
    end

    # Builds a Graph of the relations between all models
    def analyse(models)
      graph = Graph.new(models)
    end
  end
end
