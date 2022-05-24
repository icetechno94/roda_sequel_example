# frozen_string_literal: true

# User creation service
module CreateUserService
  class NotValidUser < StandardError; end

  module_function

  def call(email: '', blocked: false)
    User.create(email: email, blocked: blocked)
  rescue Sequel::ValidationFailed => _e
    raise NotValidUser
  end
end
