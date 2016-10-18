defmodule PhoenixElmJukebox.RoomChannel do
  use PhoenixElmJukebox.Web, :channel
  alias PhoenixElmJukebox.Message

  def join("room:lobby", %{"user" => user}, socket) do
    IO.puts "Joining with username: #{user}"
    send(self, :after_join)
    # Assign the user name to the socket.
    {:ok, assign(socket, :user, user)}
  end

  def handle_info(:after_join, socket) do
    # Broadcast to clients that a new user has joined.
    broadcast! socket, "joined:new", %{
      body: "just joined the lobby!",
      user_name: socket.assigns.user,
      timestamp: :os.system_time(:milli_seconds)
    }
    {:noreply, socket}
  end

  # Handle incoming messages.
  def handle_in("message:new", message, socket) do
    # Broadcast messages out to clients.
    broadcast! socket, "message:new", %{
      user_name: socket.assigns.user,
      body: message,
      timestamp: :os.system_time(:milli_seconds)
    }
    {:noreply, socket}
  end
end
