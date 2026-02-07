defmodule PlateSlateWeb.PageController do
  use PlateSlateWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
