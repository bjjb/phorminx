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

    def table_name
      @class.table_name
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
      def reflections
        @class.reflect_on_all_associations.map do |reflection|
          Reflection.new(reflection)
        end
      end

      class Reflection
        def initialize(reflection)
          @reflection = reflection
        end

        def options
          @reflection.options 
        end

        def definition
          "#{@reflection.macro} :#{@reflection.name}"
        end

        def options
          options = @reflection.options.reject { |k, v| k == :extend }
          options.inspect unless options.empty?
        end

        def conditions
          conditions = @reflection.conditions
          conditions.inspect unless conditions.all?(&:empty?)
        end

        def to_s
          [definition, options, conditions].compact.join(', ')
        end
      end

      def template
        <<-RUBY
class <%= name %> < <%= superclass_name %>
  self.table_name = '<%= table_name %>'
  <% for reflection in reflections %>
  <%= reflection.to_s %>
  <% end %>
end
        RUBY
      end
    end

    def export
      s = "# Generated using phorminx v#{Phorminx::VERSION}\n\n"
      ObjectSpace.each_object(Class).select do |k|
        k < ::ActiveRecord::Base
      end.sort_by(&:name).each do |k|
        s << k.export.to_s
        s << "\n"
      end
      s
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
