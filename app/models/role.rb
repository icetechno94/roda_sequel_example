# frozen_string_literal: true

class Role < Sequel::Model
  one_to_many :user_roles
end
