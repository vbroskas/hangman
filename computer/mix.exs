defmodule Computer.MixProject do
  use Mix.Project

  def project do
    [
      app: :computer,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hangman, path: "../hangman"},
      {:dictionary, path: "../dictionary"},
      {:text_client, path: "../text_client"}
    ]
  end
end
