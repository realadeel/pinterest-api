module Pinterest
  class Client
    module User

      def me
        get('me')
      end

      def get_followers
        get("me/followers")
      end

      def get_likes
        get("me/likes")
      end

      def get_followed_boards
        get("me/following/boards")
      end

      def get_followed_users
        get("me/following/users")
      end

      def get_followed_interests
        get("me/following/interests")
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

      def search_pins(params={})
        get('me/search/pins', query: params[:query])
      end

      def search_boards(params={})
        get('me/search/boards', query: params[:query])
      end

      def get_user(user)
        get("users/#{user}")
      end

    end
  end
end
