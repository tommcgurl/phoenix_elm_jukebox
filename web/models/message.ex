defmodule PhoenixElmJukebox.Message do
  use PhoenixElmJukebox.Web, :model

  schema "messages" do
    field :user_name, :string
    field :body, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_name, :body])
    |> validate_required([:user_name, :body])
  end
end
