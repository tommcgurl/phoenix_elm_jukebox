defmodule PhoenixElmJukebox.PageController do
  use PhoenixElmJukebox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
