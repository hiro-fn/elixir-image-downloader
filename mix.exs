defmodule ElixTwit.Mixfile do
  use Mix.Project

  def project do
    [app: :elixTwit,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     escript: [main_module: ElixTwit]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :extwitter, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:oauth, github: "tim/erlang-oauth"},
    {:extwitter, "~> 0.6"},
    {:httpoison, "~> 0.9.0"}]
  end
end