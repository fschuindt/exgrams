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
