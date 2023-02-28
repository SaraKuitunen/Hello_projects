IO.inspect("test")

version_num = 8
risteys_version = "FG"
current_FG_version = 9
current_FR_FG_version = 8
path = "/phenocode/M13_RHEUMA"

if version_num < 9 and risteys_version == "FG" do
  IO.puts("version_num < 9 and risteys_version == FG")
end

case {risteys_version, version_num} do
  {"FG", 9} ->
    IO.puts("matches 'FG' and 7")

  {"FG", v} when v < 9 ->
    IO.puts("matches 'FG' and num less than 9")
    IO.inspect("https://r#{version_num}.risteys.finngen.fi")
  _ ->
    IO.puts("matches all")
end

url =
  case {risteys_version, version_num} do
    {"FG", version_num} when version_num == current_FG_version ->
      "https://risteys.finngen.fi#{path}"
    {"FG", v} when v < current_FG_version ->
      "https://r#{version_num}.risteys.finngen.fi#{path}"
    {"FR_FG", current_FR_FG_version} ->
      "https://risteys.finngen.fi#{path}"
    {"FR_FG", v} when v < current_FR_FG_version ->
      "https://r#{version_num}-risteys.finngen.fi#{path}"
  end

IO.inspect(url)
