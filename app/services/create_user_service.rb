# frozen_string_literal: true

# User creation service
module CreateUserService
  class NotValidUser < StandardError; end
  class NotValidArgs < StandardError; end

  module_function

  def call(email: nil, blocked: false)
    raise NotValidArgs if email.nil? || !(blocked.is_a?(TrueClass) || blocked.is_a?(FalseClass))

    User.create(email: email, blocked: blocked)
  rescue Sequel::ValidationFailed => _e
    raise NotValidUser
  end
end
