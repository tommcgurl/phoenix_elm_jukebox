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

# Custom Poison Encoder for messages
# This is used to serialized the messages to send to JS
defimpl Poison.Encoder, for: PhoenixElmJukebox.Message do
  def encode(model, opts) do
    newModel = model
      |> Map.take([:user_name, :body, :inserted_at])

    Poison.Encoder.Map.encode(%{
      user_name: newModel.user_name,
      body: newModel.body,
      timestamp: newModel.inserted_at
    }, opts)
  end
end
