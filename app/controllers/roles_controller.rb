# frozen_string_literal: true

require_relative '../services/receivers/receive_role_users_service'

# Roles app
class RolesController < ApplicationController
  route do |r|
    # GET /role/:key/users
    r.is 'users' do
      ReceiveRoleUsersService.call(key: r.params['key'], offset: r.params['offset'], limit: r.params['limit'])
    end
  end
end
