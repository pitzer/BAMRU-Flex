source 'http://rubygems.org'

gem 'rails', '3.2.3'
gem 'sqlite3'
gem 'simple_form'

gem 'fastercsv'
gem 'gcal4ruby'
gem 'daemons'
gem 'whenever'
gem 'thor'

gem 'ghost'

gem 'foreman'
gem 'passenger'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0' # for ActiveModel has_secure_password

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'twitter-bootstrap-rails'

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'virtualbox'
  gem 'vagrant',      '~> 1.0.2'
  gem 'vagrant-snap'

  gem 'rspec-rails'

  gem 'pry'
  gem 'pry-doc'
  gem 'debugger'
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'wirble'
  gem 'hirb'
  gem 'drx'

  gem 'capistrano'
  share_dir = File.expand_path("~/lr/cap_share")
  if Dir.exist?(share_dir) 
    gem 'cap_share', :path => share_dir
  else
    gem 'cap_share', :git => "https://andyl@github.com/andyl/cap_share.git"
  end
end
