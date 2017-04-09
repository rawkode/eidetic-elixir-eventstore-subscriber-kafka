defmodule Eidetic.EventStore.Subscriber.Kafka.Application do
  @moduledoc false

  use Application

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Eidetic.EventStore.Subscriber.Kafka, [[name: :eidetic_eventstore_subscriber_kafka]])
    ]

    opts = [strategy: :one_for_one, name: Eidetic.EventStore.Subscriber.Kafka.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
