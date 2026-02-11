defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias PlateSlate.Menu

  object :menu_item do
    field :id, :id
    field :name, :string
    field :description, :string
    field :price, :float
  end

  query do
    @desc "The list of available items on the menu"
    field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ ->
        {:ok, Menu.list_items()}
      end
    end

  end
end
