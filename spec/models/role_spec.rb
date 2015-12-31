require 'spec_helper'

describe Role do
  describe 'registry' do
    before do
      class Role::TestRole < Role
      end
    end

    after do
      Role.registry.delete('test_role')
    end

    it 'should allow registration of role subclasses' do
      Role::TestRole.register('test_role')
      expect(Role.registry['test_role']).to eq(Role::TestRole)
    end
  end
end
