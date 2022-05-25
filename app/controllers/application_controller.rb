# frozen_string_literal: true

require './config/application'

Config::DB.connect

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

  logger = Logger.new($stdout)
  plugin :common_logger, logger
end
