# frozen_string_literal: true

require_relative 'base_receiver'

# Receiver class used to receive user roles by uuid
class ReceiveUserRolesService < BaseReceiver
  def self.call(user_uuid: nil, limit: 0, offset: 0)
    user = User.find(uuid: user_uuid)
    return [] if user.nil?

    new(object_id: user.id, limit: limit, offset: offset).serialize
  end

  private

  def keys_to_serialize
    %i[name key]
  end

  def load_user_roles
    @user_roles = UserRole.eager_graph(:role).where(user_id: object_id)
  end
end
