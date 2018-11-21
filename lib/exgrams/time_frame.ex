defmodule EXgrams.TimeFrame do
  @moduledoc """
  Calculates the execution time of a function call. Used for
  benchmarking.

  Taken from:
  [page](https://medium.com/elixirlabs/implement-a-basic-block-yield-with-elixir-d00f313831f7)

  All credits from this module goes to
  [Mustafa Turan](https://github.com/mustafaturan).

  Just changed the default unit from `:micro_seconds` to
  `:milliseconds`.
  """

  defmacro execute(name, units \\ :milliseconds, do: yield) do
    quote do
      start = System.monotonic_time(unquote(units))
      result = unquote(yield)
      time_spent = System.monotonic_time(unquote(units)) - start
      IO.puts("Executed #{unquote(name)} in #{time_spent} #{unquote(units)}")
      result
    end
  end
end
