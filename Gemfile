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
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier',             '>= 1.3.0'
gem 'slim-rails'
gem 'compass-rails',        '~> 1.1.7'
gem 'foundation-rails',     '~> 5.2'
gem 'font-awesome-rails'

group :development do
  gem 'spring'                                # Rails quick loader
  gem 'better_errors'                         # Nice errors screens
  gem 'binding_of_caller'                     # Req'd for `better_errors`

  # TEMP: Handle version issues;
  # Makes the console much nicer and provices nice dev tools
  gem 'jazz_hands',         github: 'nixme/jazz_hands',
                            branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
end

group :development, :test do
  gem 'minitest-spec-rails'                   # Testing framework
  gem 'factory_girl_rails', '~> 4.0'          # Testing factories
  gem 'database_cleaner'                      # Cleans DB between tests

  gem 'quiet_assets'                          # Reduces console output

  gem 'dotenv-rails',       '~> 0.10'         # Nicer ENV variable handling

  gem 'guard-bundler'
  gem 'guard-rails'
end

group :staging, :production do
  gem 'rails_12factor'                        # Allow heroku to compile assets
end
