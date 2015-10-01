module Pinterest
  class Client
    module Pin

      def get_pin(id)
        get("pins/#{id}")
      end

      def get_board_pins(board_id)
        get("boards/#{board_id}/pins")
      end

      def create_pin(params={})
        post('pins', params)
      end

      def update_pin(params={})
        patch('pins', params)
      end

      def delete_pin(id)
        delete("pins/#{id}")
      end

    end
  end
end
