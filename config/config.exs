# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_trello_api,
  ecto_repos: [PhoenixTrelloApi.Repo]

# Configures the endpoint
config :phoenix_trello_api, PhoenixTrelloApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OZ4oOBC3hH2l8MNFrZAzQmvPnjW4uPO2KvftTeG0tn0JiW2B/1WtmJtRE3C60yMS",
  render_errors: [view: PhoenixTrelloApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixTrelloApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
