require 'minitest/autorun'
require 'carnivore-actor'

describe 'Carnivore::Source::Actor' do

  describe 'Building an Actor based source' do

    it 'returns the source' do
      Carnivore::Source.build(:type => :actor, :args => {:name => :actor_source})
      t = Thread.new{ Carnivore.start! }
      source_wait
      Carnivore::Supervisor.supervisor[:actor_source].wont_be_nil
      t.terminate
    end

  end

  describe 'Actor source based communication' do
    before do
      @source1 = []
      @source2 = []
      MessageStore.init
      Carnivore::Source.build(:type => :actor, :args => {:name => :actor_source}).add_callback(:store) do |message|
        MessageStore.messages.push(message[:message])
      end
      @runner = Thread.new{ Carnivore.start! }
      source_wait
    end

    after do
      @runner.terminate
    end

    describe 'message transmissions' do
      it 'should accept message transmits' do
        Carnivore::Supervisor.supervisor[:actor_source].transmit('test message')
      end

      it 'should receive messages' do
        Carnivore::Supervisor.supervisor[:actor_source].transmit('test message 2')
        source_wait{ MessageStore.messages.include?('test message 2') }
        MessageStore.messages.must_include 'test message 2'
      end
    end
  end

end
