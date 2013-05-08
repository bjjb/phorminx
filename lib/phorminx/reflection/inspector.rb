require 'phorminx/reflection/inspector'

module Phorminx
  module Reflection
    def inspector
      Inspector.new(self)
    end
  end
end
