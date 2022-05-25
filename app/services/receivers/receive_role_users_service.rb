# frozen_string_literal: true

require_relative 'base_receiver'

# Receiver class used to receive users by role key
class ReceiveRoleUsersService < BaseReceiver
  def self.call(key: nil, limit: 0, offset: 0)
    role = Role.find(key: key)
    return if role.nil?

    new(object_id: role.id, limit: limit, offset: offset).serialize
  end

  private

  def keys_to_serialize
    %i[uuid email]
  end

  def load_user_roles
    @user_roles = UserRole.eager_graph(:user).where(role_id: object_id)
  end
end
