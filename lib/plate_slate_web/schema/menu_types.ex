defmodule PlateSlateWeb.Schema.MenuTypes do
    use Absinthe.Schema.Notation

    @desc "Filtering options for the menu item list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string

    @desc "Matching a category name"
    field :category, :string

    @desc "Matching a tag"
    field :tag, :string

    @desc "Priced above a value"
    field :priced_above, :float

    @desc "Priced below a value"
    field :priced_below, :float

    @desc "Added to the menu before this date"
    field :added_before, :date

    @desc "Added to the menu after this date"
    field :added_after, :date
  end

  object :menu_item do
    @desc "Unique Id for each menu item"
    field :id, :id
    @desc "Name of the menu item"
    field :name, :string
    @desc "Details about the menu"
    field :description, :string
    @desc "Date on menu addition"
    field :added_on, :date
    @desc "Price of the menu"
    field :price, :float
  end


end