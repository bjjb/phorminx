require "active_record"
require "erb"
require "phorminx/version"

module Phorminx
  class Model
    def initialize(klass)
      @class = klass
    end

    def name
      @class.name
    end

    def superclass_name
      @class.superclass.name
    end

    def to_s
      ERB.new(template).result(binding)
    end
  end

  module ActiveRecord
    class Model < Phorminx::Model
      def relations
        @class.reflect_on_all_associations.map do |relation|
          s = relation.macro.to_s
          s << ' '
          s << ":#{relation.name}"
          unless relation.options.empty?
            s << ', '
            s << relation.options.reject { |k, v| k == :extend }.inspect
          end
          s
        end.join("\n")
      end

      def template
        <<-RUBY
class #{name} < ActiveRecord::Base
#{relations}
end
        RUBY
      end
    end

    def export
      ObjectSpace.each_object(Class).select do |k|
        k < ::ActiveRecord::Base
      end.map do |k|
        k.export.to_s
      end.join("\n")
    end

    def self.extended(o)
      o.const_get(:Base).send(:include, Base)
    end

    module Base
      def self.included(mod)
        mod.send(:extend, ClassMethods)
      end

      module ClassMethods
        def export
          Model.new(self)
        end
      end
    end
  end
end

ActiveRecord.send(:extend, Phorminx::ActiveRecord)
