# frozen_string_literal: true

SimpleCov.configure do
  track_files '**/*.rb'

  coverage_dir 'coverage'

  add_filter %w[
    /.idea/
    /spec/
    /config/
    /refinements/
    /lib/
    /db/
  ]
end
