defmodule YoutubeData do
  require Logger

  def get_url(search_param) do
    query = String.replace(search_param, ~r/\s/, "+")
    "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{query}&key=<APIKEY>"
  end

  def fetch(search_param) do
    get_url(search_param)
      |> HTTPoison.get!
      |> handle_response
  end

  defp handle_response(%HTTPoison.Response{status_code: 200, body: body}) do
    IO.inspect body
    decode_body(body)
  end

  defp handle_response({:error, reason}) do
    IO.inspect reason
    {:error, reason}
  end

  defp decode_body(body) do
    Poison.decode(body)
  end
end
