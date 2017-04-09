use Mix.Config

config :kafka_ex,
  brokers: [{"${KAFKA_HOST}", 9092}]
