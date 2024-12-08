defmodule Mix.Tasks.Day.Utilities do
  @default_year "2024"
  @aoc_address "https://adventofcode.com"

  def download(day) do
    puzzle_input_url = "/#{@default_year}/day/#{@aoc_address}/#{day}/input"
  end
end
