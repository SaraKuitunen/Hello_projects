#    [
#   %{"interval" => %{
#      "left" => left,
#      "right" => right
#    },
#    "count" => count
#    },
#    %{"interval" => %{
#      "left" => left,
#      "right" => right
#    },
#    "count" => count
#    },
#     ...
#   ]



temp1 = Enum.map([1, 2, 3], fn x -> x * 2 end)
IO.inspect(temp1)

# list of tuple into a list of map
temp2 = Enum.map([{1, 2, 3}], fn {a, b, c} -> %{"a" => a, "b" => b, "c" => c} end)
IO.inspect("temp2: ")
IO.inspect(temp2)

# list of tuples into a list of maps
list_of_tuples = [
  {1, 2, 3},
  {4, 5, 6}
]

temp3 = Enum.map(list_of_tuples, fn {a, b, c} -> %{"a" => a, "b" => b, "c" => c} end)
IO.inspect("temp3: ")
IO.inspect(temp3)


# list of tuples into a list of nested maps
list_of_tuples = [
  {1, 2, 3},
  {4, 5, 6}
]

temp4 = Enum.map(list_of_tuples, fn {a, b, c} -> %{"interval" => %{"a" => a, "b" => b} , "c" => c} end)
IO.inspect("temp4: ")
IO.inspect(temp4)

# list of tuples
distrib_values= [
  {1970.0, 1975.0, 0},
  {1975.0, 1980.0, 0},
  {1980.0, 1985.0, 0},
  {1985.0, 1990.0, 0},
  {1990.0, 1995.0, 0},
  {1995.0, 2.0e3, 5},
  {2.0e3, 2005.0, 43},
  {2005.0, 2010.0, 30},
  {2010.0, 2015.0, 40},
  {2015.0, 2020.0, 49},
  {2020.0, 2021.0, 0},
  {nil, 1970.0, 0}]

IO.inspect(distrib_values)

distrib = Enum.map(distrib_values, fn {left, right, count} ->
  %{
    "interval" => %{
      "left" => left,
      "right" => right
      },
    "count" => count
  }
end)

IO.inspect("distrib: ")
IO.inspect(distrib)

IO.inspect(is_list(distrib))

IO.inspect("get first element of the list: Enum.at([1,2,3], 0)")
IO.inspect(Enum.at([1,2,3], 0))
IO.inspect(Enum.at(distrib, 0))

first_map = Enum.at(distrib, 0)
IO.inspect(first_map)

IO.inspect(Map.get(first_map, "count"))

IO.inspect("interval: ")
first_interval = Map.get(first_map, "interval")
IO.inspect(first_interval)

IO.inspect("left: ")
IO.inspect(Map.get(first_interval, "left"))

sixth_map = Enum.at(distrib, 6)
sixth_interval = Map.get(sixth_map, "interval")
sixth_left = Map.get(sixth_interval, "left")
IO.inspect(sixth_left)
IO.inspect(is_float(sixth_left))
