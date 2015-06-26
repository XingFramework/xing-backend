require 'xing-backend'
require 'active_support/deprecation'

module Xing
  DEPRECATED_CLASSES = {
    :HypermediaJSONMapper      => Xing::Mappers::Base,
    :BaseSerializer            => Xing::Serializers::Base,
    :ResourcesSerializer       => Xing::Serializers::RootResources,
    :JsonTreeLister            => Xing::Services::JsonTreeLister,
    :ActiveModelErrorConverter => Xing::Services::ErrorConverter,
    :RemoteSnapshotFetcher     => Xing::Services::SnapshotFetcher,
    :ListDifferenceBuilder     => Xing::Builders::OrderedListDifferenceBuilder
  }
end

#Xing::DEPRECATED_CLASSES.each do |old, new|

  ## with great power comes great responsibility
  #Object.const_set(old, ActiveSupport::Deprecation::DeprecatedConstantProxy.new(old, new))
#end

def Object.const_missing(name)
  if (klass = ::Xing::DEPRECATED_CLASSES[name.to_sym])
    warn "[DEPRECATION] #{name} is deprecated. Please use #{klass.to_s} instead."
    klass
  else
    super
  end
end
