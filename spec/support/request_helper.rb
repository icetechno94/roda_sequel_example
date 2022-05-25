# frozen_string_literal: true

module RequestHelper
  def response_body
    to_sym_hash(last_response.body)
  end
end
