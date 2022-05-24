# frozen_string_literal: true

require_relative '../../refinements/string_refinement'

# Role creation service
module CreateRoleService
  class NotValidRole < StandardError; end

  using StringRefinement

  module_function

  def call(name:)
    ::Role.create(name: name, key: name.underscore)
  rescue Sequel::ValidationFailed => _e
    raise NotValidRole
  end
end
