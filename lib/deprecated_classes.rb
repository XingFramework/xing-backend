require 'xing'
require 'active_support/deprecation'

Xing::DEPRECATED_CLASSES = {
  'HypermediaJSONMapper' => 'Xing::ResourceMapper',
  'BaseSerializer'       => 'Xing::ResourceSerializer',
  'JsonTreeLister'       => 'Xing::Services::JsonTreeLister'
}


Xing::DEPRECATED_CLASSES.each do |old, new|

  # with great power comes great responsibility
  Object.const_set(old, ActiveSupport::Deprecation::DeprecatedConstantProxy.new(old, new))
end
