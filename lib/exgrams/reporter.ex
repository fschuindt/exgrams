defmodule EXgrams.Reporter do
  @moduledoc """
  Used only to demonstrate the difference in performance of
  `EXgrams.of/1` running async vs. sync.

  Kinda like this:
  ```
  Executed n-grams [...] (async) in 524 milliseconds
  Executed n-grams [...] (sync) in 3328 milliseconds
  ```
  """

  require EXgrams.TimeFrame

  @subject "n-grams non-repeated permutations"

  @doc """
  Executes the benchmark over the `EXgrams.Lore.sentence/1` sentence.
  """
  @spec perform() :: EXgrams.set()
  def perform do
    perform_with(EXgrams.Lore.sentence())
  end

  @doc """
  Executes the benchmark over a given sentence.
  """
  @spec perform_with(String.t()) :: EXgrams.set()
  def perform_with(sentence) do
    EXgrams.TimeFrame.execute "#{@subject} (async)" do
      EXgrams.of(sentence)
    end

    EXgrams.TimeFrame.execute "#{@subject} (sync)" do
      EXgrams.of(sentence, :sync)
    end
  end
end
