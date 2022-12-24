import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :personality_test, PersonalityTestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "o1n36ssn7AD8GA0YdnyWBQmfr1IFzRNiPVH2ZddiFPYw5zLXYmUJNJ1gUpoq8NI4",
  server: false

# In test we don't send emails.
config :personality_test, PersonalityTest.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
