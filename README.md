# Ripper
[![Circle CI](https://img.shields.io/circleci/project/comic-ripper/ripper.svg)](https://circleci.com/gh/comic-ripper/ripper)
[![Code Climate](https://codeclimate.com/github/comic-ripper/ripper/badges/gpa.svg)](https://codeclimate.com/github/comic-ripper/ripper)
[![Dependency Status](https://gemnasium.com/comic-ripper/ripper.svg)](https://gemnasium.com/comic-ripper/ripper)

## Installation
 1. git clone git@github.com:comic-ripper/ripper
 2. Set up config/database.yml
 3. rake db:setup
 4. rake assets:install # This installs bower packages and fixes them a little

### Dependencies
 * MySQL, or some other activerecord compatible database
 * Redis, For sidekiq

### More information
* [Parsers](docs/parsers.md)
* [Models](docs/comic_models.md)
