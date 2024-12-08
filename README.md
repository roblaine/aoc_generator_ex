# AocGenerator

Generates the directory structure, boilerplate module code, and retrieves your puzzle input for a given day.

## Installation

This package depends on `curl`.

The package can be installed
by adding `aoc_generator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aoc_generator, git: "https://github.com/roblaine/aoc_generator_ex.git"}
  ]
end
```

## Usage

After adding your AOC Session Cookie to your local env, you can run this with

```sh
mix day 1
```

The param passsed to the command must be in the range [1,25].
