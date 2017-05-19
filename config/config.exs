# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :auth_sample,
  ecto_repos: [AuthSample.Repo]

# Configures the endpoint
config :auth_sample, AuthSample.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7cDFhF7mA0Oxo8UT7ftrFCAgtgaP8TmDgfCRCS/LS9G2OZZrx4EsKQ/qTQ9eDSgQ",
  render_errors: [view: AuthSample.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthSample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  hooks: GuardianDb,
  issuer: "SampleAuth",
    ttl: { 30, :days },
      secret_key: "46l5yfRFGorxAArf64nGzHlfvSDAOUEV7m6c3/lf4LzZcBfUClDsSfNETrosmsdO",
        serializer: AuthSample.GuardianSerializer

config :guardian_db, GuardianDb,
      repo: AuthSample.Repo,
      schema_name: "guardian_tokens",
      sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
