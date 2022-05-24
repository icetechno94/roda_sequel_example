# frozen_string_literal: true

class UserRole < Sequel::Model
  many_to_one :role
  many_to_one :user
end
