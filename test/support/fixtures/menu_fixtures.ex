defmodule PlateSlate.MenuFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PlateSlate.Menu` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> PlateSlate.Menu.create_category()

    category
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        added_on: ~D[2026-02-06],
        description: "some description",
        name: "some name",
        price: "120.5"
      })
      |> PlateSlate.Menu.create_item()

    item
  end
end
