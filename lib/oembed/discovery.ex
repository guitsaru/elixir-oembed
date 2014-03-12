defmodule OEmbed.Discovery do
  @moduledoc "Internal: Finds the oEmbed API endpoint for a given url."

  @doc """
  Internal: Finds the URI for the oEmbed API endpoint on a given url.

  Examples

      iex> OEmbed.Discovery.discover "https://twitter.com/mattetti/status/443849671727800320"
      "https://api.twitter.com/1/statuses/oembed.json?id=443849671727800320"

      iex> OEmbed.Discovery.discover "http://google.com"
      nil

  Returns a String URI if the url is embeddable, otherwise returns nil.
  """
  def discover(url) do
    html = url |> HTTPoison.get |> HTTPoison.Response.body

    regex = ~r/<link\s+rel="alternate"\s+type="application\/json\+oembed"\s+href="([^\"]+)"[^>]*>/
    regex |> Regex.run(html) |> oembed_link_from_match
  end

  defp oembed_link_from_match(nil), do: nil
  defp oembed_link_from_match([_]), do: nil
  defp oembed_link_from_match([_|matches]), do: List.first(matches)
end