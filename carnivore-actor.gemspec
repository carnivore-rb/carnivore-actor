$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'carnivore-actor/version'
Gem::Specification.new do |s|
  s.name = 'carnivore-actor'
  s.version = Carnivore::Actor::VERSION.version
  s.summary = 'Message processing helper'
  s.author = 'Chris Roberts'
  s.email = 'code@chrisroberts.org'
  s.homepage = 'https://github.com/carnivore-rb/carnivore-actor'
  s.description = 'Carnivore actor source'
  s.license = 'Apache 2.0'
  s.require_path = 'lib'
  s.add_dependency 'carnivore', '> 0.1.10', '< 2.0'
  s.files = Dir['lib/**/*'] + %w(carnivore-actor.gemspec README.md CHANGELOG.md)
end
