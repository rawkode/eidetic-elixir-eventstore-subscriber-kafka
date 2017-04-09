# Eidetic (EventSourcing for Elixir)

## EventStore Subscriber - Kafka

Publish events to Apache Kafka

### Work In Progress

TODO:

1. Use a behaviour to standardise functions required by a "Helper"
2. Tests! I am not sure how to test this yet

### Installation

Due to the immaturity of this library, you'll need to install through Git:

```elixir
{:eidetic_eventstore_subscriber_kafka, github: "GT8Online/eidetic-eventstore-subscriber-kafka"}
```

### Configuration

```elixir
config :eidetic_eventstore_subscriber_kafka :handler MyModule
```

MyModule should have:

```elixir
def topic(event = %Eidetic.Event{}) do
  "topic"
end

def partition(event = %Eidetic.Event{}) do
  1
end

def required_acks(event = %Eidetic.Event{}) do
  1
end
```
