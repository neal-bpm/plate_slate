defmodule PlateSlateWeb.Resolvers.Menu do
  alias PlateSlate.Menu

  def menu_items(_, args, _) do
    IO.puts("These are the arguments:#{inspect(args)}")
    {:ok, Menu.list_items(args)}
  end
end
