# frozen_string_literal: true

require_relative '../../config/models'

require 'roda'
require 'logger'

# Base app settings
class ApplicationController < Roda
  DEFAULT_HEADERS = {
    'Content-Type' => 'application/json;charset=UTF-8',
    'Cache-Control' => 'no-store',
    'Pragma' => 'no-cache'
  }.freeze

  plugin :symbol_status
  plugin :json_parser
  plugin :all_verbs
  plugin :request_headers
  plugin :params_capturing
  plugin :default_headers, DEFAULT_HEADERS

  logger = if ENV['RACK_ENV'] == 'test'
             Class.new { def write(_) end }.new
           else
             Logger.new($stdout)
           end
  plugin :common_logger, logger

  plugin :error_handler do |e|
    error = nil
    case e.class.name
    when 'Errors::InvalidRequest'
      status = 400
    when 'Errors::Base'
      status = 500
      error = 'InternalServerError'
    else
      status = 500
      error = 'InternalServerError'
      logger.error("#{e.class}: #{e.message}; backtrace: #{e.backtrace}")
    end

    response.status = status
    attributes = {
      code: status,
      error: error || e.class.name.demodulize,
      error_description: e.message
    }
    JSON.generate(attributes)
  end
end
