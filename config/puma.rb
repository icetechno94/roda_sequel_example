# frozen_string_literal: true

max_threads_count = ENV.fetch('PUMA_MAX_THREADS', 5)
min_threads_count = ENV.fetch('PUMA_MIN_THREADS', max_threads_count)
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch('PUMA_PORT', 3000)

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RACK_ENV', 'development')