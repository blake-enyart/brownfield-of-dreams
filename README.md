# Brownfield Of Dreams

This is the base repo for a brownfield project used at Turing for Backend Mod 3.

Project Spec and Evaluation Rubric: https://github.com/turingschool-examples/brownfield-of-dreams

### Project Board

Students will continue to build on the existing code base using the cards within the following Github Project: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup


Clone down the repo
```
git clone
```

Install the gem packages
```
bundle install
```

Install node packages for stimulus
```
brew install node
brew install yarn
yarn add stimulus
```

Next, you'll need to setup a YouTube API key:

 * Visit [here](https://developers.google.com/youtube/v3/getting-started) and follow the steps to create a project.
 
 * Return to [here](https://developers.google.com/youtube/v3/getting-started), click on `obtain authorization credentials`, then `Credentials page`, and create credentials for the YouTube API just generated. 
 
  **Note**: Create a new project, enable `YouTube Data API v3` API, and generate an API key NOT an OAuth 2.0 credential

 * Use the `figaro` gem to generate an `application.yml` as follows:
 ```
 bundle exec figaro install
 ```
 * Open the `config/application.yml` that was generated in your preferred editor
 
 * Copy the key generated earlier and paste that key in the `application.yml` in the following format:
 ```
 YOUTUBE_API_KEY: '<YouTube generated API key>'
 ```

Then, setup the database
```
rake db:{drop,create,migrate,seed}
```

Run the test suite:
```
bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
