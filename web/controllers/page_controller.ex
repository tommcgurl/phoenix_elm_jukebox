defmodule PhoenixElmJukebox.PageController do
  use PhoenixElmJukebox.Web, :controller
  alias PhoenixElmJukebox.Message

  def index(conn, _params) do
    # Notice that we do not use a changeset here. The assumption is that
    # data will have to pass through a changeset in order to get into
    # the database, so data coming out should already be valid.
    messages = Repo.all(Message)
    render conn, "index.html", messages: messages
  end
end
