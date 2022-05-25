# frozen_string_literal: true

module JsonHelper
  def to_sym_hash(str)
    JSON.parse(str, symbolize_names: true)
  end
end
