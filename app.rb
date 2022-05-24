# frozen_string_literal: true

Dir['./routes/**/*.rb'].sort.each { |f| require f }

# Main App
class App < Routes::Base
  route do |r|
    r.root do
      { success: true, message: 'Application server is up', env: ENV['RACK_ENV'] }.to_json
    end
  end
end
