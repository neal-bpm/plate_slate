defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias PlateSlateWeb.Resolvers

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

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
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Menu.menu_items/3)
    end
  end
end
