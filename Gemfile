source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails',                '~> 4.1.0'        # Rails
gem 'turbolinks'                              # Makes page loads faster
gem 'sqlite3', group: [:development, :test]   # Dev & Test DB
gem 'pg',      group: :production             # Production DB

# Server
gem 'thin'                                    # Nicer server
gem 'devise'                                  # User and Account Management
gem 'pundit'                                  # User and Role Authorization
gem 'attr_extras'                             # Simplified PORO's

# Javascript
gem 'jquery-rails'                            # jQuery
gem 'jquery-turbolinks'                       # Turbolinks jQuery adapter

# Assets
gem 'sass-rails',           '~> 4.0.3'
gem 'coffee-rails',         '~> 4.0.0'
gem 'uglifier',             '>= 1.3.0'
gem 'slim-rails'
gem 'compass-rails',        '~> 1.1.7'
gem 'foundation-rails'

group :development do
  gem 'better_errors'                         # Nice errors screens
  gem 'binding_of_caller'                     # Req'd for `better_errors`
  gem 'quiet_assets'                          # Reduces console output
  gem 'pry-rails'                             # some nicities for pry
  # gem 'jazz_hands'                            # pry wrapper for rails
end

group :development, :test do
  gem 'spring'                                # Rails quick loader
  gem 'dotenv-rails',       '~> 0.10'         # Nicer ENV variable handling

  gem 'guard-bundler'
  gem 'guard-rails'
end

group :staging, :production do
  gem 'rails_12factor'                        # Allow heroku to compile assets
end
