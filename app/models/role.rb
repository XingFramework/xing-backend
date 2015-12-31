require 'xing/services/class_registry'
class Role
  include Xing::Services::ClassRegistry

  #def self.registrar; Role; end

  def self.for(user)
    registry[user.role_name].new.tap do |role|
      role.user = user
    end
  end

  def self.users
    User.where(:role_name => registrar.registry_key(self))
  end

  def role_name
    user.role_name
  end

  attr_accessor :user

  Dir[File.join(Rails.root, 'app/models/role/*.rb')].each { |file| require file }
end
