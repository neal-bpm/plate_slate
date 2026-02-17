defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  import Ecto.Query

  alias PlateSlate.Menu
  alias PlateSlate.Repo

  object :menu_item do
    @desc "Unique Id for each menu item"
    field :id, :id
    @desc "Name of the menu item"
    field :name, :string
    @desc "Details about the menu"
    field :description, :string
    @desc "Price of the menu"
    field :price, :float
  end

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      arg(:matching, :string)

      resolve(fn
        _, %{matching: name}, _ when is_binary(name) ->
          name = "%#{name}%"

          query =
            from m in PlateSlate.Menu.Item,
              where: ilike(m.name, ^name)

          {:ok, Repo.all(query)}

        _, _, _ ->
          {:ok, Menu.list_items()}
      end)
    end
  end
end
