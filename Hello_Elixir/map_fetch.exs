query_result =
  [
    {{"endpoint_1", 0}, 130},
    {{"endpoint_1", 1}, 70},
    {{"endpoint_1", 2}, 60},
    {{"endpoint_2", 0}, 250},
    {{"endpoint_2", 1}, 250},
    {{"endpoint_2", 2}, 0}
  ]

IO.inspect(query_result)

db_endpoints = Enum.into(query_result, %{})

IO.inspect(db_endpoints)

endpoint = "endpoint_1"
case_counts_sex_0 = Map.fetch(db_endpoints, {endpoint, 0})

IO.inspect(case_counts_sex_0)


### same result when mimicing different db structure
# "result of sex specific DB query"

IO.inspect("same result when mimicing different db structure")

query_result_2 =
  [
    {"endpoint_1", 130},
    {"endpoint_2", 250}
  ]

IO.inspect(query_result_2)

db_endpoints_2 = Enum.into(query_result_2, %{})

IO.inspect(db_endpoints_2)

endpoint = "endpoint_1"
case_counts_all = Map.fetch(db_endpoints_2, endpoint)

IO.inspect(case_counts_all)

case_count = 10

case_percentage =
  case Map.fetch(db_endpoints_2, endpoint) do
    :error -> nil
    {:ok, total_cases} ->
      IO.inspect("total cases:")
      IO.inspect(total_cases)
      IO.inspect(is_integer(total_cases))
      IO.inspect(is_binary(total_cases))
      case_count / total_cases * 100
  end
