defmodule EXgrams do
  @moduledoc """
  Implements a set of functions to interact with words *n-grams* and
  its permutations.
  """

  @typedoc """
  A `t:EXgrams.set/0` in our context is any list of binaries.
  """
  @type set :: list(String.t())

  @doc """
  Given a sentence and the optionals: method (defaults to `:async`)
  and separator/hedge, (defaults to `" "`), it will run *n-grams*
  from 1 up to `n`, being `n` the number of words in the sentence.
  Then return its non-repeated permutations.

  Notice that prior to processing, it will replace all `"\n"`
  characters to `" "` and will stripe out all punctuation.

  The available methods are: `:sync` and `:async`.

  ## Examples

      iex> EXgrams.of("Another one bites the dust.") # Runs async.
      ["Another", "one", "bites", "the", "dust", "Another one",
      "one bites", "bites the", "the dust", "Another one bites",
      "one bites the", "bites the dust", "Another one bites the",
      "one bites the dust", "Another one bites the dust"]

      iex> EXgrams.of("Another one bites the dust.") # Runs sync.
      ["Another", "one", "bites", "the", "dust", "Another one",
      "one bites", "bites the", "the dust", "Another one bites",
      "one bites the", "bites the dust", "Another one bites the",
      "one bites the dust", "Another one bites the dust"]
  """
  @spec of(String.t(), atom(), String.t()) :: set()
  def of(sentence, method \\ :async, hedge \\ " ") do
    sentence
    |> prepare(hedge)
    |> permute(method)
    |> present()
  end

  @doc """
  Given `n` and a list of words, returns its `n`-grams.

  ## Examples

      iex> EXgrams.grams(2, ~w(Another one bites the dust))
      ["Another one", "one bites", "bites the", "the dust"]

      iex> EXgrams.grams(3, ~w(Another one bites the dust))
      ["Another one bites", "one bites the", "bites the dust"]
  """
  @spec grams(pos_integer(), set()) :: set()
  def grams(n, set) do
    set
    |> Enum.chunk_every(n, 1)
    |> Enum.filter(fn chunk -> length(chunk) == n end)
    |> Enum.map(&join/1)
  end

  @spec prepare(String.t(), String.t()) :: set()
  defp prepare(sentence, hedge) do
    sentence
    |> String.replace(~r/[\p{P}\p{S}]/, "")
    |> String.replace("\n", " ")
    |> String.split(hedge)
  end

  @spec present(list(set)) :: set()
  defp present(set_list) do
    set_list
    |> List.flatten()
    |> Enum.uniq()
  end

  @spec permute(set(), atom()) :: list(set)
  defp permute(set, :async) do
    set
    |> async_permutation()
    |> Enum.map(&Task.await/1)
  end

  defp permute(set, :sync), do: sync_permutation(set)

  @spec async_permutation(set()) :: list(Task.t())
  defp async_permutation(set) do
    for n <- 1..length(set),
        do: Task.async(fn -> grams(n, set) end)
  end

  @spec sync_permutation(set()) :: list(set)
  defp sync_permutation(set) do
    for n <- 1..length(set), do: grams(n, set)
  end

  @spec join(set()) :: String.t()
  defp join(chunk), do: Enum.join(chunk, " ")
end
