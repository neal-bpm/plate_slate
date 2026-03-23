defmodule PlateSlate.OrderingTest do
  use PlateSlateWeb.DataCase, async: true

  alias PlateSlate.Ordering
  alias PlateSlate.Ordering.Order
  alias PlateSlate.Menu

  setup do
    PlateSlate.Seeds.run()
  end

  test "create_order/1 with valid data creates a order" do
    chai = Repo.get_by(Menu.Item, name: "Masala Chai")
    fries = Repo.get_by(Menu.Item, name: "French Fries")

    attrs = %{
      state: "created",
      ordered_at: "2025-04-17 14:00:00.000000Z",
      items: [
        %{menu_item_id: chai.id, quantity: 2},
        %{menu_item_id: fries.id, quantity: 2}
      ]
    }

    assert {:ok, %Order{} = order} = Ordering.create_order(attrs)

    assert Enum.map(
             order.items,
             &Map.take(&1, [:name, :quantity, :price])
           ) == [
             %{name: "Masala Chai", quantity: 2, price: chai.price},
             %{name: "French Fries", quantity: 2, price: fries.price}
           ]

    assert order.state == "created"
  end
end
