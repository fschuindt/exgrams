# EXgrams

A research implementation on Elixir [*n-grams*](https://en.wikipedia.org/wiki/N-gram) non-repeated permutations.

[**Documentation**](https://fschuindt.docsh.io/github/exgrams/EXgrams.html#content)

# Setup

Install Hex and Rebar:
```
$ mix local.hex --force
```

```
$ mix local.rebar --force
```

Download dependencies:
```
$ mix deps.get
```

Compile everything:
```
$ mix compile
```

Run it:
```
$ iex -S mix
```

*Example:*
```
iex(1)> EXgrams.of("The well is running dry")
["The", "well", "is", "running", "dry", "The well", "well is", "is running",
 "running dry", "The well is", "well is running", "is running dry",
 "The well is running", "well is running dry", "The well is running dry"]
```

## Sync. Vs. Async.

Other cool features include the *method* choice, where you can pick to run the program sync or async (it will run async by default), eg.:
```
# This will run async.
iex(1)> EXgrams.of("One day in the year of the fox")
[...]

# This will run sync.
iex(2)> EXgrams.of("One day in the year of the fox", :sync)
[...]
```

Running it async is a huge improvement, especially for large texts. This repository offers a built-in benchmark, there you can check the performance difference of your own sentences or, if you like, it stores a 5 paragraph long *Lorem Ipsum* to be used in those experiments.


```
# Runs with the 5 paragraph long Lorem Ipsum.

iex(2)> EXgrams.Reporter.perform()

Executed n-grams non-repeated permutations (async) in 508 milliseconds
Executed n-grams non-repeated permutations (sync) in 3343 milliseconds
```

```
# Smaller the text, smaller the performance improvement.

iex(3)> EXgrams.Reporter.perform_with("Don't believe me if I tell ya, not a word of this is true.")

Executed n-grams non-repeated permutations (async) in 1 milliseconds
Executed n-grams non-repeated permutations (sync) in 1 milliseconds
```

# Development Tools

**Static code analysis**
```
$ mix credo
```

And
```
$ mix dialyzer
```

**Testing**
```
$ mix test
```
