defmodule Exgrams.MixProject do
  use Mix.Project

  def project do
    [
      app: :exgrams,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false},
      {:distillery, "~> 2.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v0.1.0",
      source_url: "https://github.com/fschuindt/exgrams",
      extras: [
        "README.md"
      ],
      groups_for_modules: [
        EXgrams: [
          EXgrams
        ]
      ]
    ]
  end
end
