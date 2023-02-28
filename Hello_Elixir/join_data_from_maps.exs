data_1 = %{e1: "e1", e2: "e2_1", f1: 1.09, f2: 5.4}
data_1_2 = %{e1: "e1", e2: "e2_2", f1: 4.09, f2: 7.4}
data_2_1 = %{e1: "e1", e2: "e2_1", f3: 54}

template = %{e1: nil, e2: nil, f1: nil, f2: nil, f3: nil, f4: nil}

results = %{}

# join data_1
# if results map doesn't include the e2 key from data map, join data to template map to have all possible fields in the map add add to results
Map.get(results, data_1.e2) # nil
# merge data to template map to include all possible fields
tmp = Map.merge(template, data_1)
results= Map.put(results, tmp.e2, tmp)

# join data_1_2
Map.get(results, data_1_2.e2) # nil -> join data to template and add new map to results map
tmp = Map.merge(template, data_1_2)
results= Map.put(results, tmp.e2, tmp)

# join data_2_1
# if results map includes the e2 key from current data map, append values from that map to the corresponding map in results
# NOTE, do not merge data with template when appending to already existing map in results because the template has all possible keys
# and when merging to results, default nil values in tmp map from the template would overwrite previously added values in the results map
Map.get(results, data_2_1.e2) # returns a map

results = Map.put(results, data_2_1.e2, Map.merge(Map.get(results, data_2_1.e2), data_2_1))

# join any data map
# in practice, data_map comes from enumerating through list of maps
# NOTE, for this to work for any data_map, all data_maps need to have have same atom key for e2 value, i.e. for id of endpoint 2
data_map = %{e1: "e1", e2: "e3_1", f1: 0.09, f2: 6.8}
data_map = %{e1: "e1", e2: "e3_1", f4: 11.3}
data_map = %{e1: "e1", e2: "e3_1", f3: 2.73}

results = case Map.get(results, data_map.e2) do
  nil ->
    tmp = Map.merge(template, data_map)
    results= Map.put(results, tmp.e2, tmp)
  map ->
    results = Map.put(results, data_map.e2, Map.merge(map, data_map))
end

results = case Map.get(results, data_map.e2) do
  nil ->
    tmp = Map.merge(template, data_map)
    Map.put(results, tmp.e2, tmp)
  map ->
    Map.put(results, data_map.e2, Map.merge(map, data_map))
end


# finally, make a list of only values of all maps
Map.values(results)
