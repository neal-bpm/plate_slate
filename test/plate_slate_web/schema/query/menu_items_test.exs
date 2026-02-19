defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  setup do
    PlateSlate.Seeds.run()
  end

  @query """
  {
    menuItems{
      name
    }
  }
  """

  test "menuItems field returns menu items" do
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"},
                 %{"name" => "Croque Monsieur"},
                 %{"name" => "Muffuletta"},
                 %{"name" => "Bánh mì"},
                 %{"name" => "French Fries"},
                 %{"name" => "Papadum"},
                 %{"name" => "Pasta Salad"},
                 %{"name" => "Water"},
                 %{"name" => "Soft Drink"},
                 %{"name" => "Lemonade"},
                 %{"name" => "Masala Chai"},
                 %{"name" => "Vanilla Milkshake"},
                 %{"name" => "Chocolate Milkshake"}
               ]
             }
           }
  end

  @query """
    {
      menuItems(matching: "reu"){
        name
      }
    }
  """

  test "menuItems field returns menu items filtered by name" do
    response = get(build_conn(), "/api", query: @query)

    assert json_response(response, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{
                   "name" => "Reuben"
                 }
               ]
             }
           }
  end

  @query """
  {
    menuItems(matching: 1){
      name
    }
  }
  """

  test "menuItems field return error when using a bad value" do
    response = get(build_conn(), "/api", query: @query)

    assert %{
             "errors" => [
               %{
                 "message" => "Argument \"matching\" has invalid value 1.",
                 "locations" => [
                   %{
                     "line" => 2,
                     "column" => 13
                   }
                 ]
               }
             ]
           } == json_response(response, 200)
  end

  @query """
  query($term: String){
    menuItems(matching: $term){
      name
    }
  }
  """
  @variables %{"term" => "reu"}
  test "menuItems field filters by name using a variable" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{
                   "name" => "Reuben"
                 }
               ]
             }
           }
  end
end
