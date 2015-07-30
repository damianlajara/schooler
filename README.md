

# Project Week 1

## Contents

This readme is organized into eight sections:

1. Guidelines
2. Requirements
3. Inspiration
4. Instructions
5. Adding Gems
6. Testing out Your Code
7. Bonus
8. Resources

## Guidelines

1. Groups
 * You may work alone or in pairs. The max group size is two.
2. Timeline
  * You will have three days of class to complete this project. 
  * Your app must have basic functionality by the early afternoon on Wednesday the 25th as you will be presenting it to the class around 4pm.
3. Approval
  * Before starting on your project, you must get your idea approved by an instructor.
4. Design
  * Your app using object oriented programming techniques
5. Components
  * Your app must fetch data from the internet by making API calls or scraping
  * Your app must be have an interactive command line interface or CLI

## Requirements

Your app should have at least three classes:

1. CLI Runner
  * One class should handle the CLI section and it should be located in the `app/runners` folder'
  * This should be interactive. Users should be able to change the way it behaves through typing keywords. Keywords that must be accounted for are:
    * help
    * exit
  * The CLI should also respond to at least two more keywords of your choosing (these will probably vary depending on the purpose of your app, some might be "start", "search", etc.).
2. Data Fetcher
  * The second class should fetch data and it will be in the `app/data_fetchers` folder
  * This could be a [Nokogiri scraper](), in which case you should name it something like BuzzFeedScraper, `app/data_fetchers/buzzfeed_scraper.rb`
  * It could also make API calls, in which case you should name it something like BuzzFeedAPICaller, `app/data_fetchers/buzzfeed_api_caller.rb`
    * If you would like help from instructors when creating the class that makes API calls, the API you select must not require authentication (that means no Twitter, no Facebook, no Instagram, etc.). You can use APIs that do require authentication as long as you're comfortable knowning that instructors will not help you debug them.
  * Finally, it could also be a data parser. You could download CSV files, JSON, spreadsheets, etc. from the internet, add them to a  `lib` folder you will create, and have your data parser parse through the files an instantiate new instances of your model class or classes.
  * Note about data fetchers: They must instantiate new instances of your model class or classes.
3. Model(s)
  * The third class should be a model of your data, in the `app/models` folder
  * If you are fetching data from Spotify for instance, an appropriate model might be Song. Song could have a couple attributes:
    * artist
    * album
    * length
    * etc.
  * Feel free to use more than one model for your data, one is the minimum

## Inspiration

These are all suggestions to get your mind churning. By no means are you limited to working with something off of the following lists.

### Data Parsing

* [NYC Open Data](https://nycopendata.socrata.com/)
* [US Open Data](http://www.data.gov/open-gov/)
* [Bachelor Contestants](https://raw.githubusercontent.com/kthffmn/bachelor-contestants/master/data.json)

### Scraping

Here are some popular websites you can scrape

* [BuzzFeed](http://www.buzzfeed.com/)
* Twitter Searches - For instance, searched for hello: [https://twitter.com/search?f=realtime&q=hello&src=typd](https://twitter.com/search?f=realtime&q=hello&src=typd)
  * Format: `"https://twitter.com/search?f=realtime&q=" + search_term + "&src=typd"`
* [Gawker](http://gawker.com/)
* [The Huffington Post](http://www.huffingtonpost.com/)
* [Imgur](http://imgur.com/)
* [New York Times](http://www.nytimes.com/)
* [Wired](http://www.wired.com/)
* [ValleyWag](http://valleywag.gawker.com/)

### APIs  

##### Here are some popular open APIs

* [Census Data](http://www.census.gov/data/developers/data-sets/population-estimates-and-projections.html)
* [The Guardian](http://open-platform.theguardian.com/documentation/)
* [Flickr](https://developer.yahoo.com/flickr/)
* [Google Places](https://developers.google.com/places/)
* [Jobs API](http://search.digitalgov.gov/developer/jobs.html)
* [New York Times](http://developer.nytimes.com/docs)
* [Open Weather](http://openweathermap.org/current)
* [Spotify Charts](http://charts.spotify.com/docs)

##### Here are some popular APIs that require authentication

*Note: Instructors will not help you debug the APIs below*

* [GitHub](https://developer.github.com/v3/)
* [Imgur](https://api.imgur.com/#endpoints)
* [Instagram](https://instagram.com/developer/)
* [Fakebook Graph API](https://developers.facebook.com/tools/explorer/145634995501895/?method=GET&path=me%3Ffields%3Did%2Cname&version=v2.2)
* [Giphy](https://github.com/Giphy/GiphyAPI)
* [Google Maps](http://www.programmableweb.com/api/google-maps)
* [Pintrest]()
* [Reddit](http://www.reddit.com/dev/api)
* [Twitter REST API](https://dev.twitter.com/rest/public)
* [Twitter Streaming API](https://dev.twitter.com/streaming/overview)
* [Tumblr](https://www.tumblr.com/docs/en/api/v2)
* [YouTube](https://developers.google.com/youtube/v3/)

*Keep in mind that instructors will not help you debug the APIs below*

## Instructions

* Choose your group or decide to work alone.
* Brainstorm ideas.
* Get your idea approved by an instructor.
* Decide who will fork this lab.
* Have everyone in your group clone down the fork onto their local machines.
* Each team member should run `bundle install`
* Get familiar with the structure of this lab:

```
├── Gemfile
├── README.md
├── app
│   ├── concerns
│   │   └── example_module.rb
│   ├── data_fetchers
│   │   ├── example_api_caller.rb
│   │   └── example_scraper.rb
│   ├── models
│   │   └── example_model.rb
│   └── runners
│       └── example_cli.rb
├── bin
│   └── run.rb
├── config
│   └── environment.rb
└── spec
    ├── example_spec.rb
    ├── fixtures
    │   └── example_fixture_file.json
    └── spec_helper.rb
```

* Think about what your model(s) will look like.
* Start replacing the example code with your own code *in this order*:
  * See what kind of data you can get from your API calls or your scraper and start to build it out
  * Given this data, make your model(s)
  * Have your data fetcher (either API caller or scraper) instantiate new instances of your model(s)
  * Once you have a functional API caller/scraper, start working on your CLI class in `app/runners/example_cli.rb`
  * Update `bin/run.rb` so that it calls on your CLI class correctly. You should be able to run `ruby bin/run.rb` from your terminal to interact with your app.
  * Once your CLI is functional, replace this readme with instructions on how to use your app.
  * If you have time, start testing your app (see the bonus section).

## Adding Gems

This lab manages gems using [Bundler](http://bundler.io/). This means that instead of writing "require `name-of-gem'` at the top of your files, you're going to add that gem to the Gemfile, for instance `gem "nokogiri"`, then run `bundle install` again. The file `config/environment.rb` requires all these gems, then loads your modules, then your models, then your scrapers/API callers, then your CLI runner. Then it requires the "json" and "open-uri" modules.

## Testing Your Code

To see what your code is like, run `rake console` from your terminal. To see why this works, take a look at the Rakefile. It loads the following items in order:

1. gems
2. modules
3. models
4. data fetchers
5. cli

## Bonus

Test your app. Refer to tests for [Playlister CLI](https://github.com/flatiron-school-ironboard/playlister-cli-bk-002) if you'd like to see how to test CLIs. Refer to [RSpec Docs](https://www.relishapp.com/rspec) (they're actually great) if you have questions.

## Resources

* [About Bundler](http://bundler.io/)
* [RSpec Docs](https://www.relishapp.com/rspec)
* [Playlister CLI](https://github.com/flatiron-school-ironboard/playlister-cli-bk-002)
