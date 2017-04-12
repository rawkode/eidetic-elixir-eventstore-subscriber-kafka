defmodule Eidetic.EventStore.Subscriber.Kafka do
  @moduledoc """
  Documentation for Kafka.
  """

  use GenServer
  require Logger

  @doc false
  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, %{
      helper: Application.get_env(:eidetic_eventstore_subscriber_kafka, :helper)
    }, options)
  end

  @doc false
  def handle_cast({:publish, event = %Eidetic.Event{}}, state) do
    case KafkaEx.produce(
      %KafkaEx.Protocol.Produce.Request{
        topic: state[:helper].topic(event),
        partition: state[:helper].partition(event),
        required_acks: state[:helper].required_acks(event),
        messages: [%KafkaEx.Protocol.Produce.Message{
          value: Poison.encode!(event)}]}
    ) do
      [%KafkaEx.Protocol.Produce.Response{partitions: [%{error_code: 0, offset: offset, partition: partition}], topic: topic}] ->
        Logger.debug("Published to Kafka")
        :ok
      error ->
        Logger.error("Failed to publish to Kafka: #{inspect error}")
        :error
    end
    {:noreply, state}
  end
end
