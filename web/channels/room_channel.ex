defmodule PhoenixElmJukebox.RoomChannel do
  use PhoenixElmJukebox.Web, :channel

  def join("room:lobby", _, socket) do
    # calls handle_info with :after_join then return the socket
    send self(), :after_join
    {:ok, socket}
  end

  def handle_info(:afterjoin, socket) do
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

end
