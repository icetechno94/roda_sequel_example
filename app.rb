# frozen_string_literal: true

Dir['./app/controllers/**/*.rb'].sort.each { |f| require f }

# Main App
class App < ApplicationController
  route do |r|
    r.root do
      { success: true, message: 'Application server is up', env: ENV['RACK_ENV'] }.to_json
    end

    r.on 'user' do
      r.run UsersController
    end
    r.on 'role' do
      r.run RolesController
    end
  end
end
