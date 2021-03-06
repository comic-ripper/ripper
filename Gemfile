source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.5'

gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

gem 'bootstrap-sass'
gem 'bootswatch-rails'

gem 'bootstrap-generators'
gem 'slim-rails'

gem 'psych', '~>2.0.0'
gem 'kaminari-bootstrap', '~> 3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem 'puma'
gem 'rails_12factor'

# Administration
gem 'rails_admin'
gem 'devise'

gem 'sidekiq'
gem 'sidekiq-middleware'
gem 'sinatra', '>= 1.3.0', require: nil # Sidekiq admin
gem 'whenever', require: false

# Building
gem 'rubyzip'

gem 'carrierwave'
gem 'carrierwave-aws'

gem 'simple_form'

gem 'airbrake'

gem 'rack-cors', require: 'rack/cors'

# Comic parsers
gem 'batoto_ripper',
    github: 'comic-ripper/batoto_ripper',
    branch: 'master'

gem 'imgur_ripper',
    github: 'comic-ripper/imgur_ripper',
    branch: 'master'

gem 'manga_eden_ripper',
    github: 'comic-ripper/manga_eden_ripper',
    branch: 'master'

gem 'dotenv-rails'
gem 'jazz_fingers'

# Testing

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'quiet_assets'

  gem 'rubocop', require: false
  gem 'parser', '~>2.3.0.pre', require: false
end
group :development, :test do
  gem 'rspec', '~> 3.3'
  gem 'rspec-rails', '~> 3.3'
  gem 'factory_girl_rails'
end

group :test do
  gem 'timecop'
  gem 'simplecov', require: false
end
# Development Gems
# gem 'better_errors', groups: [:development, :test]
gem 'activerecord-import'
gem 'colored'
