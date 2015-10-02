# Pinterest

[![Code Climate](https://codeclimate.com/github/realadeel/pinterest-api/badges/gpa.svg)](https://codeclimate.com/github/realadeel/pinterest-api)
[![Build Status](https://semaphoreci.com/api/v1/projects/17e4870c-9339-42e9-b2a1-8a7ca1d02bc2/558393/badge.svg)](https://semaphoreci.com/realdeal/pinterest-api)

This is the Ruby gem for interacting with the official [Pinterest REST API](https://developers.pinterest.com/docs/getting-started/introduction/).  

This gem uses Faraday and Hashie to make requests and parse the responses.

## Usage

Obtain an access token from Pinterest. You can generate one [here](https://developers.pinterest.com/docs/api/access_token/).

$ gem install pinterest

```ruby
require 'pinterest-api'

client = Pinterest::Client.new(ACCESS_TOKEN)

# Get the authenticated user's Pinterest account info
client.me

# Get the pins that the authenticated user likes
client.get_likes

# Get the authenticated user's followers
client.get_followers

# Get the boards that the authenticated user follows
client.get_followed_boards

# Get the Pinterest users that the authenticated user follows
client.get_followed_users

# Get the interests that the authenticated user follows
client.get_followed_interests

# Follow a user
client.follow_user('shopseen')

# Unfollow a user
client.unfollow_user('shopseen')

# Follow a board
client.follow_board(<board_id>)

# Unfollow a board
client.unfollow_board(<board_id>)

# Follow an interest
client.follow_interest(<interest_id>)

# Unfollow an interest
client.unfollow_interest(<interest_id>)

# Search for authenticated users's pins related to shoes
client.get_pins(query: 'shoes')  

# Search for authenticated users's boards related to shoes
client.get_boards(query: 'shoes')

# Get the account info for a Pinterest user
client.get_user('<username>')

```

The gem is currently under active development. Use at your own risk. See Known Issues below.  
I hope to have the gem ready for production shortly. See Contributing section below to help.  

## Known Issues

* PATCH requests not working, endpoint path is not being appended to base

## TODO

* Pagination
* OAuth
* document Mash response methods

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/realadeel/pinterest-api.  
Please provide a failing test for bug reports, and a passing test for pull requests.
