defmodule Mix.Tasks.Day do
  @moduledoc """
  Boilerplates a day and gets your input for the challenge from the advent of code website. Run with

  `mix day 10`

  """
  require Logger
  use Mix.Task

  alias Mix.Tasks.Day.Utilities

  @default_year "2024"
  @days %{
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten",
    11 => "Eleven",
    12 => "Twelve",
    13 => "Thirteen",
    14 => "Fourteen",
    15 => "Fifteen",
    16 => "Sixteen",
    17 => "Seventeen",
    18 => "Eighteen",
    19 => "Nineteen",
    20 => "Twenty",
    21 => "TwentyOne",
    22 => "TwentyTwo",
    23 => "TwentyThree",
    24 => "TwentyFour",
    25 => "TwentyFive"
  }

  def run(args) do
    with {:aoc_session_cookie, session_cookie} <- get_session_cookie() do
      create_day(String.to_integer(hd(args)), session_cookie)
    else
      {:aoc_session_cookie_not_set, nil} ->
        Logger.error(
          ~s(Please set your advent of code session cookie in your local env, like so\n\n\texport AOC_SESSION_COOKIE=<cookie-value>\n\nbefore running this mix task.)
        )
    end
  end

  defp create_day(day, session_cookie) do
    with {:ok, day_template} <- template_day_module(day),
         {data, _} <- Utilities.get_puzzle_input(day, @default_year, session_cookie),
         dir_path <- dir_to_save(day),
         :ok <- File.mkdir_p(dir_path),
         :ok <- File.write("#{dir_path}/#{Macro.underscore(Map.get(@days, day))}.ex", day_template),
         :ok <-  File.write("#{dir_path}/input", data) do
      Logger.info("Successfully created #{day} template.")
    else
      err -> IO.inspect(err)
    end
  end

  defp dir_to_save(day) do
    Path.join(File.cwd!, "/lib/day#{Integer.to_string(day)}/")
  end

  defp get_session_cookie do
    case System.get_env("AOC_SESSION_COOKIE") do
      nil -> {:aoc_session_cookie_not_set, nil}
      cookie -> {:aoc_session_cookie, cookie}
    end
  end

  defp file_path_and_day_binary(day) when is_integer(day) and day in 1..25 do
    day_to_binary = Map.get(@days, day)
    {:ok, {String.downcase("lib/day#{Integer.to_string(day)}/input"), day_to_binary}}
  end

  defp file_path_and_day_binary(_), do: {:error, "invalid_day"}

  defp template_day_module(day) do
    {:ok, {file_path, binary_day}} = file_path_and_day_binary(day)
    input_command = ~s(File.read! \"#{file_path}\")
    input_as_list = ~S(@input |> String.split("\n", trim: true\))

    {:ok,
      """
      defmodule #{binary_day} do
        @input #{input_command}
        @input_as_list #{input_as_list}

        def part_one do
          nil
        end

        def part_two do
          nil
        end
      end
     """}
  end
end
