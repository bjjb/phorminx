require 'phorminx/reflection/inspector'

module Phorminx
  module Reflection
    def self.included(mod)
      mod.send(:extend, ClassMethods)
    end

    module ClassMethods
      def inspector
        Phorminx::Reflection::Inspector.new(self)
      end
    end
  end
end
