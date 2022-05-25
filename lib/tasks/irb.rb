# frozen_string_literal: true

namespace :irb do
  irb = proc do |env|
    ENV['RACK_ENV'] = env
    trap('INT', 'IGNORE')
    dir, base = File.split(FileUtils::RUBY)
    cmd = if base.sub!(/\Aruby/, 'irb')
            File.join(dir, base)
          else
            "#{FileUtils::RUBY} -S irb"
          end
    sh "#{cmd} -r ./config/models"
  end

  desc 'Open irb shell in test mode'
  task :test do
    irb.call('test')
  end

  desc 'Open irb shell in development mode'
  task :dev do
    irb.call('development')
  end
end
