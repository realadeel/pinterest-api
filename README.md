# Pinterest

[![Code Climate](https://codeclimate.com/github/realadeel/pinterest-api/badges/gpa.svg)](https://codeclimate.com/github/realadeel/pinterest-api)  

This is the Ruby gem for interacting with the official [Pinterest REST API](https://developers.pinterest.com/docs/getting-started/introduction/).  

This gem uses Faraday and Hashie to make requests and parse the responses.

## Usage

Obtain an access token from Pinterest. You can generate one [here](https://developers.pinterest.com/docs/api/access_token/).

$ gem install pinterest

```ruby
require 'pinterest'

client = Pinterest::Client.new(ACCESS_TOKEN)

# Get the authenticated user's Pinterest account info
client.get('me/')

# Get the pins that the authenticated user likes
client.get('me/likes/')

# Get the authenticated user's followers
client.get('me/followers/')

# Get the boards that the authenticated user follows
client.get('me/following/boards/')

# Get the Pinterest users that the authenticated user follows
client.get('me/following/users/')

# Get the interests that the authenticated user follows
client.get('me/following/interests/')

# Follow a user
client.post('me/following/users/', {user: 'shopseen'})

# Unfollow a user
client.delete('me/following/users/shopseen/')

# Follow a board
client.post('me/following/boards/', {board: '<board_id>'})

# Unfollow a board
client.delete('me/following/boards/<board_id>/')

# Follow an interest
client.post('me/following/interests/', {interest: '<interest_id>'})

# Unfollow an interest
client.delete('me/following/interests/<interest_id>/')

# Search for authenticated users's pins related to shoes
client.get('me/search/pins/', query: 'shoes')

# Search for authenticated users's boards related to shoes
client.get('me/search/boards/', query: 'shoes')

# Get the account info for a Pinterest user
client.get('users/<username>/')

```

The gem is currently under active development. Use at your own risk. See Known Issues below.  
I hope to have the gem ready for production shortly. See Contributing section below to help.  

## Known Issues

* PATCH requests not working, endpoint path is not being appended to base

## TODO

* Easier method names (#create_pin vs. #post('pins/'))
* Pagination
* OAuth
* set up CI
* document Mash response methods
* release and publish to Rubygems

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/realadeel/pinterest-api.  
Please provide a failing test for bug reports, and a passing test for pull requests.
