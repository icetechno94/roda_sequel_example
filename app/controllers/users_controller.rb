# frozen_string_literal: true

require_relative '../services/receivers/receive_user_roles_service'

# Users app
class UsersController < ApplicationController
  route do |r|
    # GET /user/roles
    r.is 'roles' do
      ReceiveUserRolesService.call(user_uuid: r.params['uuid'], offset: r.params['offset'], limit: r.params['limit'])
    end
  end
end
