# Pinterest

[![Gem Version](https://badge.fury.io/rb/pinterest-api.svg)](https://badge.fury.io/rb/pinterest-api)  
[![Code Climate](https://codeclimate.com/github/realadeel/pinterest-api/badges/gpa.svg)](https://codeclimate.com/github/realadeel/pinterest-api)

This is the Ruby gem for interacting with the official [Pinterest REST API](https://developers.pinterest.com/docs/getting-started/introduction/).  

This gem uses Faraday and Hashie to make requests and parse the responses.

Battle-tested at [Shopseen](https://www.shopseen.com) to help merchants sell more.

## Usage

Obtain an access token from Pinterest. You can generate one [here](https://developers.pinterest.com/tools/access_token/).

$ gem install pinterest-api

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
> This endpoint is no longer part of the Pinterest documentation, and has always returned an error
client.follow_interest(<interest_id>)

# Unfollow an interest
> This endpoint is no longer part of the Pinterest documentation, and has always returned an error
client.unfollow_interest(<interest_id>)

# Get all of authenticated users's pins
client.get_pins  

# Get all of authenticated users's boards
client.get_boards

# Search for authenticated users's pins related to shoes
client.get_pins(query: 'shoes')  

# Search for authenticated users's boards related to shoes
client.get_boards(query: 'shoes')

# Get the account info for a Pinterest user
client.get_user('<username>')

```
## Creating pins

You can create pins as follows

```
@client.create_pin({
  board: '<username>/<board_name>' OR '<board_id>',
  note: 'My note'
  link: 'https://www.google.com',
  image_url: 'http://marketingland.com/wp-content/ml-loads/2014/07/pinterest-logo-white-1920.png'
})
```

You can also upload your own image file like so

```
@client.create_pin({
  board: '1154178055932271277',
  note: 'Test from ruby gem',
  link: 'https://www.shopseen.com',
  image: Faraday::UploadIO.new(your_file_path, "image/<image_type>")
})
```

## Authentication

You can generate access tokens through the link above, or you can use OAuth
Authentication  

In your app, make sure you have the omniauth gem installed. Add the following
to your ```intializers/omniauth.rb``` file  

```ruby

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :pinterest, ENV['PINTEREST_APP_ID'], ENV['PINTEREST_APP_SECRET']
end

```

Direct your users to ```/auth/pinterest```

Once they approve your app, they'll be redirect to your callback URL, which
should be something like ```auth/pinterest/callback``` with a hash of
OAuth values from Pinterest in ```request.env['omniauth.auth']```

For more details, check out "Integrating OmniAuth Into Your Application"  
https://github.com/intridea/omniauth

## Request options

You can set any request options that are valid in `Faraday::Connection` by adding them as a has to the Pinterest Client initializer.

Example:

```
  client = Pinterest::Client.new(ACCESS_TOKEN, {
    request: {
      timeout: 1.5,
      open_timeout: 1,
    }
  })

  counts = client.get_user('<username>', {fields: "counts"})
```

## Known Issues

The gem is currently under active development. The following issues cause the test specs to fail, though it's not clear to me that these issues are not with the Pinterest API itself.  
* PATCH requests not working, endpoint path is not being appended to base
* POST/DELETE requests for following/unfollowing interests respectively are not working

## TODO

* Pagination
* document Mash response methods

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/realadeel/pinterest-api.  
Please provide a failing test for bug reports, and a passing test for pull requests.
