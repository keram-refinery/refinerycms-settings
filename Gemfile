source 'https://rubygems.org'

gemspec

gem 'refinerycms', '~> 2.718.0.dev', github: 'keram-refinery/refinerycms', branch: 'refinery_light'
gem 'refinerycms-clientside', '~> 0.0.1', github: 'keram-refinery/refinerycms-clientside', branch: 'master'

# Add i18n support.
gem 'refinerycms-i18n', '~> 2.718.0.dev', github: 'keram-refinery/refinerycms-i18n', branch: 'refinery_light'

gem 'quiet_assets', :group => :development

# Database Configuration
unless ENV['TRAVIS']
  gem 'activerecord-jdbcsqlite3-adapter', :platform => :jruby
  gem 'sqlite3', :platform => :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  gem 'activerecord-jdbcmysql-adapter', :platform => :jruby
  gem 'jdbc-mysql', '= 5.1.13', :platform => :jruby
  gem 'mysql2', :platform => :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  gem 'activerecord-jdbcpostgresql-adapter', :platform => :jruby
  gem 'pg', :platform => :ruby
end

gem 'jruby-openssl', :platform => :jruby

group :test do
  gem 'refinerycms-testing', '~> 2.718.0.dev'
  gem 'generator_spec', '~> 0.9.0'
end


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails', '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier'

gem 'turbolinks'

gem 'jquery-rails', '~> 3.0.4'

gem 'will_paginate', '~> 3.0.5'
gem 'i18n-iso639matrix', '~> 0.0.1', github: 'keram/i18n-iso639matrix', branch: 'master'


# To use debugger
# gem 'ruby-debug', :platform => :mri_18
# or in 1.9.x:
# gem 'debugger', :platform => :mri_19

# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path('../.gemfile', __FILE__)
  eval File.read(local_gemfile)
end
