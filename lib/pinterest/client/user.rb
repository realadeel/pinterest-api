module Pinterest
  class Client
    module User

      def me(options={})
        get('me', options)
      end

      def get_followers(options={})
        get("me/followers", options)
      end

      def get_likes(options={})
        get("me/likes", options)
      end

      def get_boards(options={})
        get("me/boards", options)
      end

      def get_followed_boards(options={})
        get("me/following/boards", options)
      end

      def get_followed_users(options={})
        get("me/following/users", options)
      end

      def get_followed_interests(options={})
        get("me/following/interests", options)
      end

      def follow_user(user)
        post('me/following/users', user: user)
      end

      def unfollow_user(user)
        delete("me/following/users/#{user}")
      end

      def follow_board(board_id)
        post('me/following/boards', board: board_id)
      end

      def unfollow_board(board_id)
        delete("me/following/boards/#{board_id}")
      end

      def follow_interest(interest_id)
        post('me/following/interests', interest: interest_id)
      end

      def unfollow_interest(interest_id)
        delete("me/following/interests/#{interest_id}")
      end

      def get_pins(options={})
        options[:query] ||= '*'
        get('me/search/pins', options)
      end

      def get_boards(options={})
        options[:query] ||= '*'
        get('me/search/boards', options)
      end

      def get_user(user, options={})
        get("users/#{user}", options)
      end

    end
  end
end
