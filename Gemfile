source 'http://rubygems.org'

gem 'rails'
#gem 'mysql2', '~>0.3'

gem 'slim'
gem 'simple_form',  '~>1.5'
gem 'inherited_resources', '~>1.2'
gem 'escape_utils', '~>0.2'
gem 'devise', '~>2.0'
gem 'redcarpet', '~>2.1' # Markdown
gem 'albino', '~>1.3' # Markdown syntax highlighting
gem 'nokogiri', '~>1.5' # Parse the html for markdown syntax highlighting
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'ruby-json', '~>1.1'
gem 'rmagick'
gem 'carrierwave'
gem 'pg'
gem 'sass-rails',   '~> 3.2.3'
gem 'ZenTest'
gem "twitter-bootstrap-rails"
gem 'bootswatch-rails'
# Just a faster web server
gem 'thin'
gem "fog", "~> 1.3.1"

group :assets do
  gem 'therubyracer' # JavaScript runtime. uglifier dependence
  gem 'uglifier'
end

group :development, :test do
  gem 'sqlite3-ruby'
  gem 'factory_girl_rails', '~>1.1'
  gem 'rspec', '~>2.6'
  gem 'rspec-rails', '~>2.6'
  gem 'valid_attribute', '~>1.1'
  gem 'capybara', '~>1.0'
  gem 'launchy', '>=2.0' # save_and_open_page
  gem 'cucumber-rails', '~>1.0', :require => false
  gem 'database_cleaner', '~>0.6'

  # Speedy test iterations
  gem 'spork', '~> 0.9.0.rc' # See: http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html
end

group :development do
  gem 'rails3-generators'
  gem 'pry'
  gem 'pry-doc'

  gem 'meta_request'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'awesome_print'
  gem 'annotate'

  gem 'quiet_assets'
  gem "less-rails", "~> 2.3.3"
end
