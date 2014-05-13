require 'carnivore/source'

module Carnivore
  class Source
    # Actor based Carnivore source
    class Actor < Source

      # Initialize source storage
      #
      # @return [TrueClass]
      def setup(*args)
        @messages = []
        true
      end

      # Receive messages
      #
      # @return [Array<Object>]
      def receive(*args)
        wait(:available_messages)
        current_messages
      end

      # Send messages
      #
      # @param payload [Object]
      # @return [TrueClass]
      def transmit(payload, *args)
        @messages << payload
        signal(:available_messages)
        true
      end

      # Get current messages and clear store
      #
      # @return [Array<Object>]
      def current_messages
        msgs = @messages.dup
        @messages.clear
        msgs
      end
    end
  end
end
