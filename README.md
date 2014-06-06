Red Steel
=========

[![Build Status](https://snap-ci.com/GEhO6qTegOcOh-Zp3mAs-AzUStu7ZcNaAeEyQ8ujNTk/build_image)](https://snap-ci.com/elsom25/redsteel/branch/master)

Don't let living together get in the way of living together.

Setup
-----

We are using `Ruby v2.1.2`, managed through `RVM`; `sqlite3`; and `PhantomJS`. To setup your system for development, follow the guides below to success. If something doesn't work (or your OS is missing), feel free to update this `README` ;)

### OSX Specific

1. Install [Xcode](https://developer.apple.com/xcode/downloads/) or Xcode Developer Tools:
  - Download Xcode form the App Store, OR
  - `xcode-select --install`
1. Install [Homebrew](http://brew.sh/):
  - `ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`
  - `brew update`
1. Setup [RVM](http://rvm.io/rvm/install):
  - `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
1. Setup ruby: `rvm install ruby-2.1.2` and `rvm use ruby-2.1.2`
1. Setup [PhantomJS](https://github.com/teampoltergeist/poltergeist)
  - `brew install phantomjs`

### All Systems

1. Install gems: `bundle install`
1. Setup your environment variables:
  - create a file in the application root: `.env`
    - The format of the file is `Key=Value`, with a newline separating each key.
    - All required keys are below. If a correpsonding value is not specified, talk to Jesse to get the value.
  - Cookie Secret:
    - Key = `SECRET_KEY_BASE`, Value = result of `rake secret`
  - Mandrill:
    - Key = `MANDRILL_USERNAME`
    - Key = `MANDRILL_APIKEY`
  - Facebook:
    - Key = `FACEBOOK_ID`
    - Key = `FACEBOOK_SECRET`
  - Twitter:
    - Key = `TWITTER_ID`
    - Key = `TWITTER_SECRET`

Run
---

1. `bundle exec guard`
2. Feel special!
3. `exit` to quit (not `ctrl+c`! That only works with `rails s`)

Tests
-----

* To run all tests: `rake`
* To run a specific test file: `rake test TEST=test/models/widget_test.rb`
* To run a specific test within a file: `ruby -Ilib:test test/models/widget_test.rb -n test_0003_refreshes`

Code Quality
------------

* To run all code quality metrics: `rake quality`
* There are lots of different tests you can run individually:
  * `rake quality:reek`
  * `rake quality:flog`
    * `rake quality:average` - checks that the average flog score is below a set threshold
    * `rake quality:each` - indicates which methods are above a set threshold
  * `rake quality:flay`
  * `rake quality:rails_best_practices`

Useful Things
-------------

* You'll see a link to this on every PR, but if you ever feel like checking in on our Continuos Integration, head on over to [Snap](https://snap-ci.com/elsom25/redsteel/branch/master)!
* Our story management is handled by [Trello](https://trello.com/b/K3CEC8cd/tech-planning)! Don't forget to name branches after the story codes.
