require 'carnivore/source'

module Carnivore
  class Source
    # Actor based Carnivore source
    class Actor < Source

      option :cache_signals

      # Initialize source storage
      #
      # @return [TrueClass]
      def setup(*args)
        true
      end

      # Receive messages
      #
      # @return [Array<Object>]
      def receive(*args)
        new_message = wait(:new_messages)
        begin
          new_message = MultiJson.load(new_message)
          new_message.respond_to?(:to_smash) ? new_message.to_smash : new_message
        rescue MultiJson::ParseError
          new_message
        end
      end

      # Send messages
      #
      # @param payload [Object]
      # @return [TrueClass]
      # @note if `:remote_name` exists in arguments, transmission
      #   is made to "remote" source instead of self (jackal hack)
      def transmit(payload, *args)
        if(arguments[:remote_name])
          Carnivore::Supervisor.supervisor[arguments[:remote_name]].async.transmit(payload)
          true
        else
          signal(:new_message, MultiJson.dump(payload))
          true
        end
      end

    end
  end
end
