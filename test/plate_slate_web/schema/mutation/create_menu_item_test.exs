defmodule PlateSlateWeb.Schema.Mutation.CreateMenuItemTest do
  use PlateSlateWeb.ConnCase, async: true

  alias PlateSlate.{Menu, Repo}
  import Ecto.Query

  setup do
    PlateSlate.Seeds.run()

    category_id =
      from(t in Menu.Category, where: t.name == "Sandwiches")
      |> Repo.one!()
      |> Map.fetch!(:id)
      |> to_string()

    {:ok, category_id: category_id}
  end

  @query """
  mutation ($input: MenuItemInput!){
    createMenuItem(input: $input){
      errors{
        key
        message
      }
      menuItem{
        name
        description
        price
      }
    }
  }
  """
  test "createMenuItem field create menu item", %{category_id: category_id} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Chicken, Carmelized Onions, Horseradish ...",
      "price" => "5.75",
      "category_id" => category_id
    }

    conn = build_conn()
    conn = post conn, "/api", query: @query, variables: %{"input" => menu_item}

    assert json_response(conn, 200) == %{
             "data" => %{
               "createMenuItem" => %{
                 "errors" => nil,
                 "menuItem" => %{
                   "name" => menu_item["name"],
                   "description" => menu_item["description"],
                   "price" => menu_item["price"]
                 }
               }
             }
           }
  end

  # test "creating a menu item with an existing name fails", %{category_id: category_id} do
  #   menu_item = %{
  #     "name" => "Reuben",
  #     "description" => "Chicken, Carmelized Onions, Horseradish ...",
  #     "price" => "5.75",
  #     "category_id" => category_id
  #   }

  #   conn = build_conn()
  #   conn = post conn, "/api", query: @query, variables: %{"input" => menu_item}

  #   assert json_response(conn, 200) == %{
  #            "data" => %{
  #              "createMenuItem" => %{
  #                "errors" => [
  #                  %{"key" => "name", "message" => "has already been taken"}
  #                ],
  #                "menuItem" => nil
  #              }
  #            }
  #          }
  # end
end
