OEmbed
======

An oEmbed consumer for Elixir.

It currently only supports discoverable endpoints.

Install
-------

Add to your mix.exs

```elixir
  defp deps do
    [
      {:oembed, "~> 0.1", github: "guitsaru/elixir-oembed"}
    ]
  end
```

After adding OEmbed as a dependency, to install run:

```console
mix deps.get
```

Usage
-----

```elixir
OEmbed.start
OEmbed.for "https://twitter.com/mattetti/status/443849671727800320"
```
