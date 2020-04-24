module Pinterest
  class Client
    module Pin

      def get_pin(id, options={})
        get("pins/#{id}", options)
      end

      def get_board_pins(board_id, options={})
        get("boards/#{board_id}/pins", options)
      end

      def create_pin(params={})
        put('pins', params)
      end

      def save_pin(pin_id, params={})
        post("partners/pins/#{pin_id}/save", params)
      end

      def update_pin(id, params={})
        patch("pins/#{id}", params)
      end

      def delete_pin(id)
        delete("pins/#{id}")
      end

    end
  end
end
