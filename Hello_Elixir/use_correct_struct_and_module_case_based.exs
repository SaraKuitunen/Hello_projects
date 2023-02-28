distribution_type = "age"
distrib_module = ""

case distribution_type do
  "age" ->
    IO.inspect("%AgeDistribution{}")
    distrib_module = "AgeDistribution"
  "year" ->
    IO.inspect("%YearDistribution{}")
    distrib_module = "YearDistribution"
end

distrib_module =
  if distribution_type == "age" do
    AgeDistribution
  else
    YearDistribution
  end


IO.inspect(distrib_module)

left = 1000

message_text =
  "Data import stopped.
  You're trying to import #{distribution_type} histogram data but the
  input data has a histogram bin edge value of #{left}, which is not on expected range.
  Please check your input data and the argument for distribution type."

case distribution_type do
  "age" ->
    if left > 200 and !is_nil(left) do
      IO.inspect(message_text)
    end
  "year" ->
    if left < 1000 and !is_nil(left) do
      IO.inspect(message_text)
    end
end
