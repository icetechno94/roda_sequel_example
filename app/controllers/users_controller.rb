# frozen_string_literal: true

require_relative '../services/receivers/receive_user_roles_service'

# Users app
class UsersController < ApplicationController
  route do |r|
    # GET /user/roles
    r.is 'roles' do
      ReceiveUserRolesService.call(**user_params(r.params)).to_json
    end
  end

  def user_params(params)
    {
      user_uuid: params['uuid'],
      offset: params['offset'],
      limit: params['limit']
    }
  end
end
