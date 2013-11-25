require 'carnivore/source'

module Carnivore
  class Source
    class Actor < Source

      def setup(*args)
        @messages = []
      end

      def receive(*args)
        wait(:available_messages)
        current_messages
      end

      def transmit(*args)
        @messages << args.first
        signal(:available_messages)
      end

      def current_messages
        msgs = @messages.dup
        @messages.clear
        msgs
      end
    end
  end
end
