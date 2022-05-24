# frozen_string_literal: true

# Parent class for receivers
class BaseReceiver
  def self.call(*)
    raise ''
  end

  attr_reader :user_roles

  def initialize(object_id:, limit: 0, offset: 0)
    @object_id = object_id
    @limit = limit.to_i
    @offset = offset.to_i
    load_by_id
  end

  def serialize
    user_roles.map { |user_role| user_role.slice(*keys_to_serialize) }.to_json
  end

  private

  attr_reader :object_id, :limit, :offset

  def load_by_id
    load_user_roles
    set_limit
    set_offset
  end

  def set_limit
    @user_roles = user_roles.limit(limit) unless limit.to_i.zero?
  end

  def set_offset
    @user_roles = user_roles.offset(offset) unless offset.to_i.zero?
  end

  def load_user_roles
    raise ''
  end

  def keys_to_serialize
    raise ''
  end
end
