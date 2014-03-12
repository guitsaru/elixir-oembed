defmodule OEmbed do
  @moduledoc "Public: An oEmbed consumer."
  alias OEmbed.Discovery

  @doc """
  Public: Starts the OEmbed app.

  Currently only starts HTTPoison as a dependency.

  Returns nothing.
  """
  def start do
    HTTPoison.start
  end

  @doc """
  Public: Retrieves the JSON encoded oEmbed for the given URL.

  url - The String URI to embed.

  Examples

      iex> OEmbed.for "https://twitter.com/mattetti/status/443849671727800320"
      "{\\"cache_age\\":\\"3153600000\\",\\"url\\":\\"https:\\\\/\\\\/twitter.com\\\\/mattetti\\\\/statuses\\\\/443849671727800320\\",\\"height\\":null,\\"provider_url\\":\\"https:\\\\/\\\\/twitter.com\\",\\"provider_name\\":\\"Twitter\\",\\"author_name\\":\\"Matt Aimonetti\\",\\"version\\":\\"1.0\\",\\"author_url\\":\\"https:\\\\/\\\\/twitter.com\\\\/mattetti\\",\\"type\\":\\"rich\\",\\"html\\":\\"\\\\u003Cblockquote class=\\\\\\"twitter-tweet\\\\\\"\\\\u003E\\\\u003Cp\\\\u003EListening to \\\\u003Ca href=\\\\\\"https:\\\\/\\\\/twitter.com\\\\/josevalim\\\\\\"\\\\u003E@josevalim\\\\u003C\\\\/a\\\\u003E explain how his magic fingers wrote \\\\u003Ca href=\\\\\\"https:\\\\/\\\\/twitter.com\\\\/elixirlang\\\\\\"\\\\u003E@elixirlang\\\\u003C\\\\/a\\\\u003E for him \\\\u003Ca href=\\\\\\"http:\\\\/\\\\/t.co\\\\/QpIr2ihfn1\\\\\\"\\\\u003Epic.twitter.com\\\\/QpIr2ihfn1\\\\u003C\\\\/a\\\\u003E\\\\u003C\\\\/p\\\\u003E&mdash; Matt Aimonetti (@mattetti) \\\\u003Ca href=\\\\\\"https:\\\\/\\\\/twitter.com\\\\/mattetti\\\\/statuses\\\\/443849671727800320\\\\\\"\\\\u003EMarch 12, 2014\\\\u003C\\\\/a\\\\u003E\\\\u003C\\\\/blockquote\\\\u003E\\\\n\\\\u003Cscript async src=\\\\\\"\\\\/\\\\/platform.twitter.com\\\\/widgets.js\\\\\\" charset=\\\\\\"utf-8\\\\\\"\\\\u003E\\\\u003C\\\\/script\\\\u003E\\",\\"width\\":550}"

      iex> OEmbed.for "http://google.com"
      nil

  Returns a JSON encoded String if the url is embeddable, otherwise nil.
  """
  def for(url) do
    url |> Discovery.discover |> oembed_from
  end

  defp oembed_from(nil), do: nil
  defp oembed_from(url), do: url |> HTTPoison.get |> HTTPoison.Response.body
end
