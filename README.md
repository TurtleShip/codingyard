[![Build Status](https://travis-ci.org/TurtleShip/codingyard.svg?branch=master)](https://travis-ci.org/TurtleShip/codingyard)

# Overview

This is source code for [Codingyard website](http://codingyard.com). The website is built to share solutions to coding competitions. Feel free to fork this repo and create your own Codingyard for your programming team.

# Dependencies

- Ruby (2.2.3)
- Rails (4.2.4)
- AWS account (S3, Simple Email Service)

# Environmental variables

Create ```.env``` file in root directory of codingyard, and provide your AWS credentials as below.

```yml
AWS_ACCESS_KEY_ID='key id to your AWS account'
AWS_SECRET_ACCESS_KEY='Access key to your AWS account'
AWS_REGION='your AWS region'
MASTER_BUCKET='your AWS S3 bucket name where solutions will be stored.'
```

# How to run tests

Currently I have tests in both ```spec``` and ```rspec```. Eventually I plan to move all ```spec``` tests to ```rspec```

Run the below commands to run tests.
```
bundle exec rake test
bundle exec rspec spec
```

# Contribution guide
1. Fork me.
2. Create a feature branch in your forked repo.
3. Submit a PR when you are ready ;)

***If you happen to be good at creating a favicon, please feel free to suggest one for Codingyard. I drew [the current favicon](app/assets/images/favicon.ico), and I am no artist.***

## For those who remember the original Codingyard

I originally wrote the site using [Dropwizard](http://www.dropwizard.io/) + AngularJS and I thought I was awesome enough to accomplish tasks common to web development by pulling different libraries and using them myself. Well, I was able to do some, but then development cycle became quite slow and I got tired, frustrated, and eventually quit working on it... :(

I learned my lesson, and re-wrote the website in Ruby on Rails. Here is the [original source code](https://github.com/TurtleShip/codingyard-deprecated) I wrote using Dropwizard.
