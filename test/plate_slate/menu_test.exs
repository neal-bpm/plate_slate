defmodule PlateSlate.MenuTest do
  use PlateSlate.DataCase

  alias PlateSlate.Menu

  describe "categories" do
    alias PlateSlate.Menu.Category

    import PlateSlate.MenuFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Menu.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Menu.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Category{} = category} = Menu.create_category(valid_attrs)
      assert category.name == "some name"
      assert category.description == "some description"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Category{} = category} = Menu.update_category(category, update_attrs)
      assert category.name == "some updated name"
      assert category.description == "some updated description"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_category(category, @invalid_attrs)
      assert category == Menu.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Menu.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Menu.change_category(category)
    end
  end

  describe "items" do
    alias PlateSlate.Menu.Item

    import PlateSlate.MenuFixtures

    @invalid_attrs %{name: nil, description: nil, price: nil, added_on: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Menu.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Menu.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{name: "some name", description: "some description", price: "120.5", added_on: ~D[2026-02-06]}

      assert {:ok, %Item{} = item} = Menu.create_item(valid_attrs)
      assert item.name == "some name"
      assert item.description == "some description"
      assert item.price == Decimal.new("120.5")
      assert item.added_on == ~D[2026-02-06]
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", price: "456.7", added_on: ~D[2026-02-07]}

      assert {:ok, %Item{} = item} = Menu.update_item(item, update_attrs)
      assert item.name == "some updated name"
      assert item.description == "some updated description"
      assert item.price == Decimal.new("456.7")
      assert item.added_on == ~D[2026-02-07]
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_item(item, @invalid_attrs)
      assert item == Menu.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Menu.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Menu.change_item(item)
    end
  end
end
