module Carnivore
  module Actor
    # Custom version class
    class Version < Gem::Version
    end
    # Current version of library
    VERSION = Version.new('0.1.2')
  end
end
