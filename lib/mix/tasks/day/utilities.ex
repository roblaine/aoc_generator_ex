defmodule Mix.Tasks.Day.Utilities do
  @aoc_url "https://adventofcode.com"

  def get_puzzle_input(day, year, session_cookie) do
    puzzle_input_url = puzzle_input_url(day, year)

    curl_opts = ["-b session=#{session_cookie}", puzzle_input_url]
    case System.cmd("curl", curl_opts) do
      {:ok, data} -> {:ok, data}
      err -> err
    end
  end

  def puzzle_input_url(day, year) do
    "#{@aoc_url}/#{year}/day/#{day}/input"
  end
end
