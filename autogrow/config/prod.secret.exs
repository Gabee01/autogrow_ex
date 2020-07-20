# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    "1mvwNaiG7gwIofHFoU1EIBEzYby7yEOgHvjT5yqvJ3/YclsLlzAtEIoUlR7lZQUu"

config :autogrow_server, AutogrowServerWeb.Endpoint,
    http: [port: 80],
    url: [host: "autogrow.local", port: 80],
    secret_key_base: secret_key_base,
    root: Path.dirname(__DIR__),
    server: true,
    render_errors: [view: AutogrowServerWeb.ErrorView, accepts: ~w(html json), layout: false],
    pubsub_server: AutogrowServer.PubSub,
    live_view: [signing_salt: "037tr3tR"],
    cache_static_manifest: "priv/static/cache_manifest.json",
    transport_options: [socket_opts: [:inet6]]


# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :autogrow_server, AutogrowServerWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
