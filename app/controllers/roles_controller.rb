# frozen_string_literal: true

require_relative '../services/receivers/receive_role_users_service'

# Roles app
class RolesController < ApplicationController
  route do |r|
    # GET /role/:key/users
    r.is 'users' do
      ReceiveRoleUsersService.call(**role_params(r.params)).to_json
    end
  end

  def role_params(params)
    {
      key: params['key'],
      offset: params['offset'],
      limit: params['limit']
    }
  end
end
