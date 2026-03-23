defmodule PlateSlateWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.ChannelTest

      @endpoint PlateSlateWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PlateSlate.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PlateSlate.Repo, {:shared, self()})
    end

    :ok
  end
end
