# Carnivore Actor

Provides Actor `Carnivore::Source`

# Usage

## Basic

```ruby
require 'carnivore'
require 'carnivore-actor'

Carnivore.configure do
  source = Carnivore::Source.build(:type => :actor)
end
```

## Specify destination name

```
Carnivore.configure do
  source = Carnivore::Source.build(
    :type => :actor,
    :args => {
      :name => 'source_name'
    }
  )
end
```

# Info
* Carnivore: https://github.com/carnivore-rb/carnivore
* Repository: https://github.com/carnivore-rb/carnivore-actor
* IRC: Freenode @ #carnivore
