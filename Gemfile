source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails',                '~> 4.1.0'        # Rails
gem 'turbolinks'                              # Makes page loads faster
gem 'pg',      group: :production             # Production DB
gem 'sqlite3', group: [:development, :test]   # Dev & Test DB

# Server
gem 'thin'                                    # Nicer server
gem 'devise'                                  # User and Account Management
gem 'omniauth-facebook'
gem 'omniauth-gplus'
gem 'omniauth-twitter'
gem 'pundit'                                  # User and Role Authorization
gem 'attr_extras'                             # Simplified PORO's
gem 'simple_form'                             # A nice form DSL
gem 'country_select'                          # Provides a Country select for simple_form

# Code Quality
gem 'term-ansicolor'
gem 'flog'
gem 'flay'
gem 'reek'
gem 'rails_best_practices'

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
end

group :development, :test do
  gem 'minitest-spec-rails'                   # Testing framework
  gem 'minitest-reporters'

  gem 'capybara'                              # Integration Tests
  gem 'capybara_minitest_spec'                # Capybara integration w/ MiniTest
  gem 'poltergeist'                           # Capybara headless JS driver
  gem 'factory_girl_rails', '~> 4.0'          # Testing factories

  gem 'quiet_assets'                          # Reduces console output
  gem 'dotenv-rails',       '~> 0.10'         # Nicer ENV variable handling

  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-minitest'

  # TEMP: Handle version issues;
  # Makes the console much nicer and provices nice dev tools
  gem 'jazz_hands',         github: 'nixme/jazz_hands',
                            branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
end

group :staging, :production do
  gem 'rails_12factor'                        # Allow heroku to compile assets
end
