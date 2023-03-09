defmodule ECommers.Repo do
  use Ecto.Repo,
    otp_app: :e_commers,
    adapter: Ecto.Adapters.Postgres
end
