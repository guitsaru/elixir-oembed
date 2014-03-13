defmodule OEmbed.Discovery do
  @moduledoc "Internal: Finds the oEmbed API endpoint for a given url."

  @doc """
  Internal: Finds the URI for the oEmbed API endpoint on a given url.

  Examples

      iex> OEmbed.Discovery.discover "http://vimeo.com/82985780"
      "http://vimeo.com/api/oembed.json?url=http%3A%2F%2Fvimeo.com%2F82985780"

      iex> OEmbed.Discovery.discover "https://twitter.com/mattetti/status/443849671727800320"
      "https://api.twitter.com/1/statuses/oembed.json?id=443849671727800320"

      iex> OEmbed.Discovery.discover "http://google.com"
      nil

      iex> OEmbed.Discovery.discover "http://asdgkahsdlgkjalsdfsadghi238.com"
      nil

  Returns a String URI if the url is embeddable, otherwise returns nil.
  """
  def discover(url) do
    html = try do
      HTTPoison.get(url).body
    rescue
      HTTPoison.HTTPError -> ""
    end

    regex = ~r/<link[^>]*type="application\/json\+oembed"[^>]*>/
    regex |> Regex.run(html) |> link_from_match |> href_from_link
  end

  defp link_from_match(nil), do: nil
  defp link_from_match([link]), do: link

  defp href_from_link(nil), do: nil
  defp href_from_link(link) do
    ~r/href=["|']([^"']+)["|']/ |> Regex.run(link) |> oembed_link_from_match
  end

  defp oembed_link_from_match(nil), do: nil
  defp oembed_link_from_match([_]), do: nil
  defp oembed_link_from_match([_|matches]), do: List.first(matches)
end
