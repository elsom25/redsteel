Red Steel
=========

Don't let living together get in the way of living together.

Setup (OSX)
-----------

1. install xcode/xcode developer tools/homebrew
2. `brew update`
3. Setup ruby: `rvm install ruby-2.1.2` and `rvm use ruby-2.1.2`
4. Install gems: `bundle install`
5. Setup your environment variables:
  - create a file in the application root: `.env`
    - The format of the file is `Key=Value`, with a newline separating each key.
  - Cookie Secret:
    - Key = `SECRET_KEY_BASE`
    - Value = result of `rake secret`
  - Mandrill Username:
    - Key = `MANDRILL_USERNAME`
    - Value = NOT USED YET
  - Mandrill API Key:
    - Key = `MANDRILL_APIKEY`
    - Value = NOT USED YET

Run
---

1. `bundle exec guard`
2. Feel special!
3. `exit` to quit (not `ctrl+c`! That only works with `rails s`)
