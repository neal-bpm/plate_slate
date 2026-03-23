defmodule PlateSlateWeb.SubscriptionCase do
  # require Phoenix.ChannelTest
  use ExUnit.CaseTemplate

  using do
    quote do
      use PlateSlateWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: PlateSlateWeb.Schema

      setup do
        PlateSlate.Seeds.run()

        {:ok, socket} =
          Phoenix.ChannelTest.connect(PlateSlateWeb.UserSocket, %{})

        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)
        {:ok, socket: socket}
      end

      import unquote(__MODULE__), only: [menu_item: 1]
    end
  end

  def menu_item(name) do
    PlateSlate.Repo.get_by!(PlateSlate.Menu.Item, name: name)
  end
end
