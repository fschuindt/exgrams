defmodule EXgrams do
  @moduledoc """
  Implements a set of functions to interact with words *n-grams* and
  its permutations.

  **Tips for improving performance:**
  - Spawn a process for each `grams/2` call.
  """

  @typedoc """
  A `t:EXgrams.set/0` in our context is any list of binaries.
  """
  @type set :: list(String.t())

  @doc """
  Given a sentence and a optional separator, (defaults to `" "`), it
  will run *ngrams* from 1 up to `n`, being `n` the number of words
  in the sentence. Then return its non-repeated permutations.

  ## Examples

      iex> EXgrams.of("Show me the code")
      ["Show", "me", "the", "code", "Show me", "me the", "the code",
      "Show me the", "me the code", "Show me the code"]
  """
  @spec of(String.t(), String.t()) :: set()
  def of(sentence, hedge \\ " ") do
    sentence
    |> String.split(hedge)
    |> permute()
    |> List.flatten()
    |> Enum.uniq()
  end

  @doc """
  Given `n` and a list of words, returns its `n`-grams.

  ## Examples

      iex> EXgrams.grams(2, ~w(Show me the code))
      ["Show me", "me the", "the code", "code"]

      iex> EXgrams.grams(3, ~w(Show me the code))
      ["Show me the", "me the code", "the code"]
  """
  @spec grams(pos_integer(), set()) :: set()
  def grams(n, set) do
    set
    |> Enum.chunk_every(n, 1)
    |> Enum.map(&present/1)
  end

  @spec permute(set()) :: list(set)
  defp permute(set), do: for(n <- 1..length(set), do: grams(n, set))

  @spec present(set()) :: String.t()
  defp present(chunk), do: Enum.join(chunk, " ")
end
