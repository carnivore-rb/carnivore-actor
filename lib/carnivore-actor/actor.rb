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
      # @note if `:remote_name` exists in arguments, transmission
      #   is made to "remote" source instead of self (jackal hack)
      def transmit(payload, *args)
        if(arguments[:source_name])
          Carnivore::Supervisor.supervisor[arguments[:remote_name]].transmit(payload)
          true
        else
          @messages << payload
          signal(:available_messages)
          true
        end
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
