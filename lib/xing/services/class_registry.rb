module Xing
  module Services
    module ClassRegistry
      module ClassMethods
        def registry
          @registry ||= {}
        end

        def register(name, klass=self)
          raise "Invalid registration: #{name} exists" if registrar.registry.has_key?(name) && registrar.registry[name] != klass
          registrar.registry[name] = klass
        end

        def registry_key(klass)
          registrar.registry.select{ |key, val| val == klass}.keys.first
        end

        def registry_get(name)
          registrar.registry.fetch(name)
        end
      end

      def self.included(base)
        base.define_singleton_method(:registrar) do
          base
        end
        base.extend(ClassMethods)
      end
    end
  end
end
