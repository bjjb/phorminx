require 'phorminx/active_record/inspector'

module Phorminx
  module ActiveRecord
    def self.included(mod)
      mod.send(:extend, ClassMethods)
    end

    module ClassMethods
      def inspector
        Phorminx::ActiveRecord::Inspector.new(self)
      end
    end
  end
end
