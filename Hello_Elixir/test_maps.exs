mortality_data = %{name: "endpoint.name", longname: "endpoint.longname"}

key = :new_key
mortality_data = Map.put_new(mortality_data, key, "new value")


sex = "female"
key = String.to_atom(sex <> "_bch")

mortality_data = Map.put_new(mortality_data, key, "sex-specific results")

sex_specific_results = %{}
#bch = %{0 => 34, 1 => 53}
# bch = []
bch = [
  {37.0, 0.002973686483282174},
  {49.0, 0.008239867516936885},
  {59.0, 0.02128689669337496}
]

IO.inspect("bch:")
IO.inspect(bch)
#sex_specific_results =
#  case bch do
#    [] -> Map.put_new(sex_specific_results, :bch, nil)
#    bch -> Map.put_new(sex_specific_results, :bch, bch)
#  end



#bch =
#  case bch do
#    [] ->  nil
#    bch -> Enum.into(bch, %{})
#  end

#sex_specific_results = Map.put_new(sex_specific_results, :bch, bch)


sex_specific_results =
  case bch do
    [] ->  Map.put_new(sex_specific_results, :bch, nil)
    bch -> Map.put_new(sex_specific_results, :bch,  Enum.into(bch, %{}))
  end




IO.inspect("bch:")
IO.inspect(bch)





IO.inspect("sex_specific_results: ")
IO.inspect(sex_specific_results)
#IO.inspect(mortality_data)

test_value = Map.get(sex_specific_results.bch, 37.0)
IO.inspect(test_value)



#######
#bch =
#  case bch do
#    [] -> nil
#    map ->
#      Enum.reduce(%{}, fn {age, baseline_cumulative_hazard}, acc ->
#        Map.put_new(acc, age, baseline_cumulative_hazard)
#      end)
#  end
