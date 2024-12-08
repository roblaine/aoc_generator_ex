defmodule Mix.Tasks.Day do
  @moduledoc """
  Boilerplates a day and gets your input for the challenge from the advent of code website. Run with

  `mix day 10`

  """

  require Logger
  use Mix.Task

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
    day = String.to_integer(hd(args))
    Mix.shell().info(Enum.join(args, " "))
    # with
    # {:aoc_session_cookie, session_cookie} = get_session_cookie() |> IO.inspect(label: :cookie)
    # create_day(day, session_cookie)
    # else
    #   {:aoc_session_cookie_not_set, nil} ->
    #     Logger.error(
    #       ~s(Please set your advent of code session cookie in your local env, like so\n\n\texport AOC_SESSION_COOKIE=<cookie-value>\n\nbefore running this mix task.)
    #     )
    # end
  end

  defp create_day(day, session_cookie) do
    with {:ok, day_template} <- template_day_module(day),
         {:ok, input} <- download_input(day, session_cookie) do
      IO.inspect(day_template)
    else
      error -> Logger.error(error)
    end
  end

  # defp create_day(_, _), do: {:error, :invalid_params}

  defp download_input(day, session_cookie) do
    # @aoc_address
    {:ok, ""}
  end

  defp get_session_cookie do
    case System.get_env("AOC_SESSION_COOKIE") do
      nil -> {:aoc_session_cookie_not_set, nil}
      cookie -> {:aoc_session_cookie, cookie}
    end
  end

  defp file_path_and_day_binary(day) when is_integer(day) and day in 1..25 do
    day_to_binary = Map.get(@days, day)
    {:ok, {String.downcase("lib/#{day_to_binary}/input"), day_to_binary}}
  end

  defp file_path_and_day_binary(_), do: {:error, "invalid_day"}

  defp template_day_module(day) do
    {:ok, {file_path, binary_day}} = file_path_and_day_binary(day)
    input_command = ~s(File.read!(#{file_path}\))
    input_as_list = ~s(@input |> String.split\(\"\n\", trim: true\))

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
