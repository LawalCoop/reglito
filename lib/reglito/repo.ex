defmodule Reglito.Repo do
  use Ecto.Repo,
    otp_app: :reglito,
    adapter: Ecto.Adapters.Postgres
end
