require "active_record"
require "phorminx/version"
require "phorminx/active_record"
require "phorminx/reflection"

module Phorminx
end

ActiveRecord::Base.send(:extend, Phorminx::ActiveRecord) if defined?(ActiveRecord::Base)
ActiveRecord::Reflection::AssociationReflection.send(:include, Phorminx::Reflection) if defined?(ActiveRecord::Reflection::AssociationReflection)
