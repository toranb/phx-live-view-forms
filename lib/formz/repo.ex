defmodule Formz.Repo do
  use Ecto.Repo,
    otp_app: :formz,
    adapter: Ecto.Adapters.Postgres
end
