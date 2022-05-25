# frozen_string_literal: true

require_relative '../../lib/string'

# Role creation service
module CreateRoleService
  class NotValidRole < StandardError; end
  class NotValidArgs < StandardError; end

  module_function

  def call(name: nil)
    raise NotValidArgs if name.nil? || !name.is_a?(String)

    ::Role.create(name: name, key: name.underscore)
  rescue Sequel::ValidationFailed => _e
    raise NotValidRole
  end
end
