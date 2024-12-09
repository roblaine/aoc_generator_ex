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

1. Sign in to `https://adventofcode.com` 
2. view your session cookie in dev tools
   - Chrome: DevTools (F12) > Application > Cookies > https://adventofcode.com
   - Firefox: DevTools (F12) > Storage > Cookies > https://adventofcode.com
4. Export the Value of your cookie in your env under the key `AOC_SESSION_COOKIE` in your terminal
```sh
export AOC_SESSION_COOKIE='your_session_cookie_here'
```

5. Run the generator via mix in your project   
```sh
mix day 1
```

The param passsed to the command must be in the range [1,25].
