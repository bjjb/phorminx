require "active_record"
require "phorminx/version"
require "phorminx/active_record_inspector"

module Phorminx
  module ActiveRecord
    def inspector
      Phorminx::ActiveRecordInspector.new
    end
  end

  module Reflection
    def inspector
      Phorminx::ReflectionInspector.new(self)
    end
  end
end

ActiveRecord::Base.send(:extend, Phorminx::ActiveRecord) if defined?(ActiveRecord::Base)
ActiveRecord::Reflection::AssociationReflection.send(:include, Phorminx::Reflection) if defined?(ActiveRecord::Reflection::AssociationReflection)
