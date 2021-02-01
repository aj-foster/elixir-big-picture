# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :dots, DotsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rmeIefL3ZvflL0CprCZ291ZZNueO/DSsW3NERKtcF7685EZVIzS4T+/3txXIQIJi",
  render_errors: [view: DotsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dots.PubSub,
  live_view: [signing_salt: "b9N9XkmY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
