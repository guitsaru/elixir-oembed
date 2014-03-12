defmodule OEmbed.Mixfile do
  use Mix.Project

  def project do
    [ app: :oembed,
      version: "0.1.0",
      elixir: "~> 0.13.0-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      { :httpoison, "~> 0.0.2", github: "knewter/httpoison", branch: "0.13_application_start_fix" }
    ]
  end
end