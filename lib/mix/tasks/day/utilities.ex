defmodule Mix.Tasks.Day.Utilities do
  @default_year "2024"
  @aoc_url "https://adventofcode.com"

  def get_puzzle_input(day, session_cookie \\ nil) do
puzzle_input_url = Mix.Tasks.Day.Utilities.puzzle_input_url(day)

path_to_file =
System.tmp_dir!()
|> Path.join("/#{day}/input")
|> String.to_charlist()

headers = [{~s(cookie), ~s(53616c7465645f5fd29bbe52222e5b1f4a150495b578b407bd2bef10f59042de1b25b80cb1b5e947406afb501ee14d6789737b232d928dd928f02139de89cd9d)}]
http_request_opts = [
ssl: [
cacerts: :public_key.cacerts_get(),
customize_hostname_check: [
match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
]
]
]
{:ok, :saved_to_file} =:httpc.request(:get,{puzzle_input_url, headers},http_request_opts,[stream: path_to_file],:user)
  end

  def puzzle_input_url(day, year \\ @default_year) do
    "#{@aoc_url}/#{year}/day/#{day}/input"
  end

  def configure_httpc_client do
    IO.inspect(:httpc.get_options(:all, :user), label: :get_options)

    cookies = [{:session,  ""}]
    :httpc.store_cookies(cookies, @aoc_url, :user)
    IO.inspect(:httpc.which_cookies(:user), label: :get_cookies)
  end
end
